dnl Copyright (c) 2015 - present Facebook, Inc.
dnl All rights reserved.
dnl
dnl This source code is licensed under the BSD style license found in the
dnl LICENSE file in the root directory of this source tree. An additional grant
dnl of patent rights can be found in the PATENTS file in the same directory.

dnl AC_ASSERT_OCAML_PKG([pkg_name], [pkg_version])
dnl
dnl fails if $pkg_name is not installed; also fails if it is not
dnl installed at version $pkg_version if specified
AC_DEFUN([AC_ASSERT_OCAML_PKG],
[dnl
  AC_CHECK_OCAML_PKG_PATH([$1], [$2], [$3])

  unset has_pkg
  unset pkg

  has_pkg=$AS_TR_SH[OCAML_PKG_$1]
  AS_IF([test "$has_pkg" = "no"],
  [dnl
   unset opam_command
   unset version
    opam_command="opam pin add $1 $3"
    version=".$3"
    AS_IF([test "x$3" = "x"],
      [opam_command="opam install $1"
      version=""])
    AC_MSG_ERROR([missing dependency: $1$version.

If you are using opam, please run

  $opam_command])
  ])
])


