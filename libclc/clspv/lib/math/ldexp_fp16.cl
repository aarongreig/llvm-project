#include "fp16.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_OVERLOAD _CLC_DEF half ldexp(half x, int k) {
  float p = pown(2.f, k);
  float f_result = (float)x * p;
  half result = 0.f;
  // If the result would be a subnormal when represented with a half we need to
  // be careful about rounding
  if (fabs(f_result) < 0.00006104f) {
    float subnormal_rounded = f_result;
    uint sub_rnd = (uint)0x01000000;
    uint sub_mul = (uint)0x46000000;
    subnormal_rounded *= as_float(sub_rnd);  // round subnormals
    subnormal_rounded *= as_float(sub_mul);  // correct subnormal exp
    result = (half)subnormal_rounded;
  } else {
    result = (half)f_result;
  }

  result = isinf(f_result) ? (as_short(result) & (short)0x8000
                                  ? as_half((short)NINFBITPATT_DP16)
                                  : as_half((short)PINFBITPATT_DP16))
                           : result;
  result = isinf(x) ? (as_short(x) & (short)0x8000
                           ? as_half((short)NINFBITPATT_DP16)
                           : as_half((short)PINFBITPATT_DP16))
                    : result;

  result = fabs(f_result) > HALF_MAX && !isnan(x)
               ? x >= 0.h ? as_half((short)PINFBITPATT_DP16)
                          : as_half((short)NINFBITPATT_DP16)
               : result;
  result = x == 0.h || x == -0.h || k == 0 ? x : result;
  return result;
}

_CLC_BINARY_VECTORIZE(_CLC_DEF _CLC_OVERLOAD, half, ldexp, half, int)

#endif  // cl_khr_fp16
