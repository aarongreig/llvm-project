/*
 * University of Illinois/NCSA
 * Open Source License
 *
 * Copyright (c) 2014-2016, Advanced Micro Devices, Inc.
 * All rights reserved.
 *
 * Developed by:
 *
 *     AMD Research and AMD HSA Software Development
 *
 *     Advanced Micro Devices, Inc.
 *
 *     www.amd.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * with the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 *     * Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimers.
 *
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimers in the
 *       documentation and/or other materials provided with the distribution.
 *
 *     * Neither the names of the LLVM Team, University of Illinois at
 *       Urbana-Champaign, nor the names of its contributors may be used to
 *       endorse or promote products derived from this Software without specific
 *       prior written permission.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
 * CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH
 * THE SOFTWARE.
 */

#include "fp16.h"
#include "fp16_trig.h"

#ifdef cl_khr_fp16
#pragma OPENCL EXTENSION cl_khr_fp16 : enable

_CLC_DEF _CLC_OVERLOAD half sinpi(half x) {
  struct redret r = trigpired(fabs(x));
  struct scret sc = sincospired(r.hi);

  short s = as_short((r.i & (short)1) == (short)0 ? sc.s : sc.c);
  s ^= (r.i > (short)1 ? (short)0x8000 : (short)0) ^
       (as_short(x) & (short)0x8000);

  s = isnan(x) || isinf(x) ? (short)QNANBITPATT_DP16 : s;

  return as_half(s);
}

_CLC_UNARY_VECTORIZE(_CLC_DEF _CLC_OVERLOAD, half, sinpi, half)

#endif  // cl_khr_fp16
