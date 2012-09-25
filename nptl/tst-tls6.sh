#! /bin/sh
# A tls test.
# Copyright (C) 2003-2012 Free Software Foundation, Inc.
# This file is part of the GNU C Library.

# The GNU C Library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.

# The GNU C Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with the GNU C Library; if not, see
# <http://www.gnu.org/licenses/>.

set -e

common_objpfx=$1; shift
elf_objpfx=$1; shift
rtld_installed_name=$1; shift
cross_test_wrapper=$1; shift
run_with_env=$1; shift
logfile=$common_objpfx/nptl/tst-tls6.out

# We have to find libc and nptl
library_path=${common_objpfx}:${common_objpfx}nptl
tst_tls5="${elf_objpfx}${rtld_installed_name} --library-path ${library_path} \
	  ${common_objpfx}/nptl/tst-tls5"
tst_tls5="$cross_test_wrapper $run_with_env $tst_tls5"

LC_ALL=C
export LC_ALL
LANG=C
export LANG

> $logfile
fail=0

preloads () {
    l=''
    for s in "$@"; do
        l="$l ${common_objpfx}nptl/tst-tls5mod$s.so"
    done
    echo $l | sed 's/:$//;s/: /:/g'
}

for aligned in a e f; do
  echo "preload tst-tls5mod{$aligned,b,c,d}.so" >> $logfile
  echo "===============" >> $logfile
  EGLIBC_TEST_LD_PRELOAD=`preloads $aligned b c d` \
	      ${tst_tls5} >> $logfile || fail=1
  echo >> $logfile

  echo "preload tst-tls5mod{b,$aligned,c,d}.so" >> $logfile
  echo "===============" >> $logfile
  EGLIBC_TEST_LD_PRELOAD=`preloads b $aligned c d` \
	      ${tst_tls5} >> $logfile || fail=1
  echo >> $logfile

  echo "preload tst-tls5mod{b,c,d,$aligned}.so" >> $logfile
  echo "===============" >> $logfile
  EGLIBC_TEST_LD_PRELOAD=`preloads b c d $aligned` \
	      ${tst_tls5} >> $logfile || fail=1
  echo >> $logfile
done

echo "preload tst-tls5mod{d,a,b,c,e}" >> $logfile
echo "===============" >> $logfile
EGLIBC_TEST_LD_PRELOAD=`preloads d a b c e` \
	    ${tst_tls5} >> $logfile || fail=1
echo >> $logfile

echo "preload tst-tls5mod{d,a,b,e,f}" >> $logfile
echo "===============" >> $logfile
EGLIBC_TEST_LD_PRELOAD=`preloads d a b e f` \
	    ${tst_tls5} >> $logfile || fail=1
echo >> $logfile

exit $fail
