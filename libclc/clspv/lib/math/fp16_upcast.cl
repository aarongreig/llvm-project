#include "fp16.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_HALF_IMPL_UNARY(half, acosh, half)
_CLC_HALF_IMPL_UNARY(half, atan, half)
_CLC_HALF_IMPL_UNARY(half, atanpi, half)
_CLC_HALF_IMPL_UNARY(half, cbrt, half)
_CLC_HALF_IMPL_UNARY(half, lgamma, half)
_CLC_HALF_IMPL_UNARY(half, log1p, half)
_CLC_HALF_IMPL_UNARY(half, logb, half)
_CLC_HALF_IMPL_UNARY(half, tanh, half)
_CLC_HALF_IMPL_UNARY(int, ilogb, half)

_CLC_HALF_IMPL_BINARY(atan2)
_CLC_HALF_IMPL_BINARY(atan2pi)
_CLC_HALF_IMPL_BINARY(fmod)
_CLC_HALF_IMPL_BINARY(remainder)

#endif
