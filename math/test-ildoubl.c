/* Copyright (C) 1997-2013 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Andreas Jaeger <aj@suse.de>, 1997.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#define FUNC(function) function##l
#define FLOAT long double
#define TEST_MSG "testing long double (inline functions)\n"
#define MATHCONST(x) x##L
#define CHOOSE(Clongdouble,Cdouble,Cfloat,Cinlinelongdouble,Cinlinedouble,Cinlinefloat) Cinlinelongdouble
#define PRINTF_EXPR "Le"
#define PRINTF_XEXPR "La"
#define PRINTF_NEXPR "Lf"
#define TEST_INLINE
#define TEST_LDOUBLE 1

#ifdef __NO_MATH_INLINES
# undef __NO_MATH_INLINES
#endif

#include "libm-test.c"
