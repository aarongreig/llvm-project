/*
 * Copyright (c) 2014 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "fp16.h"
#include "fp16_trig.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

struct scret sincosred(half x) {
  half t = x * x;
  half s = mad(x, t * mad(t, 0x1.0bp-7h, -0x1.554p-3h), x);
  half c = mad(t, mad(t, 0x1.4b4p-5h, -0x1.ffcp-2h), 1.0h);

  struct scret ret;
  ret.c = c;
  ret.s = s;
  return ret;
};

struct redret trigred(half hx) {
  const float twobypi = 0x1.45f306p-1f;
  const float pb2_a = 0x1.92p+0f;
  const float pb2_b = 0x1.fap-12f;
  const float pb2_c = 0x1.54442ep-20f;

  float x = (float)hx;
  float fn = rint(x * twobypi);

  float ret_hi = mad(fn, -pb2_c, mad(fn, -pb2_b, mad(fn, -pb2_a, x)));

  struct redret ret;
  ret.hi = ret_hi >= HALF_MAX ? as_half((short)PINFBITPATT_DP16) : (half)ret_hi;
  ret.i = (int)fn & 0x3;
  return ret;
}

struct redret trigpired(half x) {
  half fraction = fmin(0.5h * x - floor(0.5h * x), as_half((short)0x3BFF));
  half t = 2.0h * fraction;
  x = x > 1.0h ? t : x;
  t = rint(2.0h * x);

  struct redret ret;
  ret.hi = mad(t, -0.5h, x);
  ret.i = (short)t & (short)0x3;
  return ret;
}

struct scret sincospired(half x) {
  half t = x * x;

  half sx = mad(t, 0x1.b84p+0h, -0x1.46cp+2h);
  sx = x * t * sx;
  sx = mad(x, 0x1.92p+1h, sx);

  half cx = mad(t, 0x1.fbp+1h, -0x1.3bcp+2h);
  cx = mad(t, cx, 1.0h);

  struct scret ret;
  ret.c = cx;
  ret.s = sx;
  return ret;
}

half tanpired(half x, short i) {
  half s = x * x;

  half t = mad(s, mad(s, 0x1.3d8p+8h, 0x1.fe4p+4h), 0x1.508p+3h);

  t = x * s * t;
  t = mad(x, 0x1.92p+1h, t);

  half tr = -native_recip(t);

  return i ? tr : t;
}

half tanred(half x, short i) {
  half s = x * x;

  half t = mad(s, mad(s, 0x1.794p-4h, 0x1.e3cp-4h), 0x1.57p-2h);
  t = mad(x, s * t, x);

  half tr = -(1 / t);

  return i ? tr : t;
}

#endif  // cl_khr_fp16
