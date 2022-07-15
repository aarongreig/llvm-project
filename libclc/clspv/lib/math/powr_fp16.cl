#include "fp16.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_OVERLOAD _CLC_DEF half powr(half x, half k) {
  float f_result = powr((float)x, (float)k);
  half result = (half)f_result;
  result = isinf(f_result) ? (as_short(result) & (short)0x8000
                                  ? as_half((short)NINFBITPATT_DP16)
                                  : as_half((short)PINFBITPATT_DP16))
                           : result;

  result = f_result > HALF_MAX && !isnan(x) ? as_half((short)PINFBITPATT_DP16)
                                            : result;
  bool x_inf = isinf(x);
  bool x_negative = as_short(x) & 0x8000;
  bool k_negative = as_short(k) & 0x8000;
  bool k_nan = isnan(k);
  bool k_zero = k == 0.h || k == -0.h;
  result = x_inf ? (k_zero ? as_half((short)QNANBITPATT_DP16) : x) : result;
  result = x_inf && x_negative ? as_half((short)QNANBITPATT_DP16) : result;
  result = x_inf && k_negative && !x_negative && !k_zero ? as_half((short)0)
                                                         : result;
  result = x_inf && k_nan ? k : result;
  return result;
}

_CLC_BINARY_VECTORIZE(_CLC_DEF _CLC_OVERLOAD, half, powr, half, half)

#endif  // cl_khr_fp16
