#include "fp16.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

int _CLC_DEF _CLC_OVERLOAD signbit(half x) { return as_short(x) < 0; }

short2 _CLC_DEF _CLC_OVERLOAD signbit(half2 x) {
  return (short2)(as_short(x.lo) < 0 ? (short)-1 : (short)0,
                  as_short(x.hi) < 0 ? (short)-1 : (short)0);
}

short3 _CLC_DEF _CLC_OVERLOAD signbit(half3 x) {
  return (short3)(as_short(x.x) < 0 ? (short)-1 : (short)0,
                  as_short(x.y) < 0 ? (short)-1 : (short)0,
                  as_short(x.z) < 0 ? (short)-1 : (short)0);
}

short4 _CLC_DEF _CLC_OVERLOAD signbit(half4 x) {
  return (short4)(as_short(x.x) < 0 ? (short)-1 : (short)0,
                  as_short(x.y) < 0 ? (short)-1 : (short)0,
                  as_short(x.z) < 0 ? (short)-1 : (short)0,
                  as_short(x.w) < 0 ? (short)-1 : (short)0);
}

short8 _CLC_DEF _CLC_OVERLOAD signbit(half8 x) {
  return (short8)(as_short(x.s0) < 0 ? (short)-1 : (short)0,
                  as_short(x.s1) < 0 ? (short)-1 : (short)0,
                  as_short(x.s2) < 0 ? (short)-1 : (short)0,
                  as_short(x.s3) < 0 ? (short)-1 : (short)0,
                  as_short(x.s4) < 0 ? (short)-1 : (short)0,
                  as_short(x.s5) < 0 ? (short)-1 : (short)0,
                  as_short(x.s6) < 0 ? (short)-1 : (short)0,
                  as_short(x.s7) < 0 ? (short)-1 : (short)0);
}

short16 _CLC_DEF _CLC_OVERLOAD signbit(half16 x) {
  return (short16)(as_short(x.s0) < 0 ? (short)-1 : (short)0,
                   as_short(x.s1) < 0 ? (short)-1 : (short)0,
                   as_short(x.s2) < 0 ? (short)-1 : (short)0,
                   as_short(x.s3) < 0 ? (short)-1 : (short)0,
                   as_short(x.s4) < 0 ? (short)-1 : (short)0,
                   as_short(x.s5) < 0 ? (short)-1 : (short)0,
                   as_short(x.s6) < 0 ? (short)-1 : (short)0,
                   as_short(x.s7) < 0 ? (short)-1 : (short)0,
                   as_short(x.s8) < 0 ? (short)-1 : (short)0,
                   as_short(x.s9) < 0 ? (short)-1 : (short)0,
                   as_short(x.sa) < 0 ? (short)-1 : (short)0,
                   as_short(x.sb) < 0 ? (short)-1 : (short)0,
                   as_short(x.sc) < 0 ? (short)-1 : (short)0,
                   as_short(x.sd) < 0 ? (short)-1 : (short)0,
                   as_short(x.se) < 0 ? (short)-1 : (short)0,
                   as_short(x.sf) < 0 ? (short)-1 : (short)0);
}

#endif  // cl_khr_fp16
