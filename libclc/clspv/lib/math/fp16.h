#include <clc/as_type.h>
#include <clc/clc.h>

#include "../../../generic/lib/clcmacro.h"
#include "../../../generic/lib/math/math.h"

#ifndef FP16_H_INCLUDED
#define FP16_H_INCLUDED

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

#define HALF_NAN 0x7E80
#define HALF_MAX 65504.f

#define _CLC_HALF_IMPL_UNARY(RET_TY, FUNCTION, OP_TY) \
  _CLC_OVERLOAD _CLC_DEF RET_TY FUNCTION(OP_TY x) {   \
    return (RET_TY)FUNCTION((float)x);                \
  }                                                   \
  _CLC_UNARY_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, RET_TY, FUNCTION, OP_TY)

#define _CLC_HALF_IMPL_BINARY(FUNCTION)                  \
  _CLC_OVERLOAD _CLC_DEF half FUNCTION(half x, half y) { \
    return (half)FUNCTION((float)x, (float)y);           \
  }                                                      \
  _CLC_BINARY_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, half, FUNCTION, half, half)

#endif  // cl_khr_fp16

#endif  // FP16_H_INCLUDED
