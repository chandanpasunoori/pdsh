##*****************************************************************************
## $Id$
##*****************************************************************************
#  AUTHOR:
#    Albert Chu <chu11@llnl.gov>
#
#  SYNOPSIS:
#    AC_MQSH
#
#  DESCRIPTION:
#    Checks for mqsh option, and sets up nettools definitions
#
#  WARNINGS:
#    This macro must be placed after AC_PROG_CC or equivalent.
##*****************************************************************************

AC_DEFUN([AC_CHECK_AF_DECL],
[
  # IEEE standard says they should be in sys/socket.h
  AC_CHECK_DECL($1, AC_DEFINE($2,1,[have $1]),,[#include <sys/socket.h>])
])


AC_DEFUN([AC_NETTOOLS],
[
  # The net-tools library originally came from the net-tools package
  # (which includes netstat, ipconfig, and some other commands) .  It is
  # not autoconf/automaked to begin with and #defines are set through
  # manual configuration.
  #
  # By pure magic luck, the net-tools library does "#include "config.h" 
  # for its configuration.  So we can configure net-tools by having them
  # include our config.h instead.
  #
  # However, we must create #defines that the library specifically
  # uses.  We can't use the standard ones created from autoconf macros.
  #

  # check for domain types 
  AC_CHECK_AF_DECL([AF_UNIX],   [HAVE_AFUNIX])
  AC_CHECK_AF_DECL([AF_INET],   [HAVE_AFINET])
  AC_CHECK_AF_DECL([AF_INET6],  [HAVE_AFINET6])
  AC_CHECK_AF_DECL([AF_IPX],    [HAVE_AFIPX])
  AC_CHECK_AF_DECL([AF_ATALK],  [HAVE_AFATALK])
  AC_CHECK_AF_DECL([AF_AX25],   [HAVE_AFAX25])
  AC_CHECK_AF_DECL([AF_NETROM], [HAVE_AFNETROM])
  AC_CHECK_AF_DECL([AF_ROSE],   [HAVE_AFROSE])
  AC_CHECK_AF_DECL([AF_X25],    [HAVE_AFX25])
  AC_CHECK_AF_DECL([AF_ECONET], [HAVE_AFECONET])
  AC_CHECK_AF_DECL([AF_DECnet], [HAVE_AFDECnet])
  AC_CHECK_AF_DECL([AF_ASH],    [HAVE_AFASH])

  # define all hardware.  All HW headers should exist even if kernel
  # modules are not loaded or installed
  AC_DEFINE(HAVE_HWETHER,1,[have ethernet])
  AC_DEFINE(HAVE_HWARC,1,[have ARCnet])
  AC_DEFINE(HAVE_HWSLIP,1,[have SLIP])
  AC_DEFINE(HAVE_HWPPP,1,[have PPP])
  AC_DEFINE(HAVE_HWTUNNEL,1,[have IPIP])
  AC_DEFINE(HAVE_HWSTRIP,1,[have STRIP])
  AC_DEFINE(HAVE_HWTR,1,[have Token Ring])
  AC_DEFINE(HAVE_HWAX25,1,[have AX25])
  AC_DEFINE(HAVE_HWROSE,1,[have Rose])
  AC_DEFINE(HAVE_HWNETROM,1,[have NET/ROM])
  AC_DEFINE(HAVE_HWX25,1,[have X.25])
  AC_DEFINE(HAVE_HWFR,1,[have DLCI/FRAD])
  AC_DEFINE(HAVE_HWSIT,1,[have SOT])
  AC_DEFINE(HAVE_HWFDDI,1,[have FDDI])
  AC_DEFINE(HAVE_HWHIPPI,1,[have HIPPI])
  AC_DEFINE(HAVE_HWASH,1,[have ASH])
  AC_DEFINE(HAVE_HWHDLCLAPB,1,[have HDLC/LAPB])
  AC_DEFINE(HAVE_HWIRDA,1,[have IrDA])
  AC_DEFINE(HAVE_HWEC,1,[have Econet])
])

AC_DEFUN([AC_MQSH],
[
  #
  # Check for whether to include mqsh module
  #
  AC_MSG_CHECKING([for whether to build mqsh module])
  AC_ARG_WITH([mqsh],
    AC_HELP_STRING([--with-mqsh], 
        [Build mqsh module, requires --with-elan and --with-mrsh]),
    [ case "$withval" in
        no)  ac_with_mqsh=no ;;
        yes) ac_with_mqsh=yes ;;
        *)   AC_MSG_RESULT([doh!])
             AC_MSG_ERROR([bad value "$withval" for --with-mqsh]) ;;
      esac
    ]
  )
  AC_MSG_RESULT([${ac_with_mqsh=no}])
   
  # following already guaranteed to exist by earlier check
  MQSH_LIBS="-lmunge"

  if test "$ac_with_mqsh" = "yes"; then
     ac_have_mqsh=yes
     PROG_MQSHD=in.mqshd   
     AC_NETTOOLS
  else
     ac_have_mqsh=no
  fi      

  AC_SUBST(MQSH_LIBS)
  AC_SUBST(PROG_MQSHD)
])
