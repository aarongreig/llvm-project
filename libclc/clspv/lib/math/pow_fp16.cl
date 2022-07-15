#include "fp16.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_DEF _CLC_OVERLOAD half pow(half x, half y) {
  float float_result = pow((float)x, (float)y);
  half ret = (half)float_result;
  ret = isinf(float_result) ? float_result >= 0.f
                                  ? as_half((short)PINFBITPATT_DP16)
                                  : as_half((short)NINFBITPATT_DP16)
                            : ret;
  ret = isnan(float_result) ? as_half((short)QNANBITPATT_DP16) : ret;
  ret = !isinf(ret) && fabs(float_result) > HALF_MAX
            ? float_result >= 0.f ? as_half((ushort)PINFBITPATT_DP16)
                                  : as_half((ushort)NINFBITPATT_DP16)
            : ret;

  return ret;
}

_CLC_BINARY_VECTORIZE(_CLC_DEF _CLC_OVERLOAD, half, pow, half, half)

#endif  // cl_khr_fp16
