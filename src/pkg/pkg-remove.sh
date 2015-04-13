#!/bin/sh

. @@LIBDIR@@/pkg/def.sh
. @@LIBDIR@@/pkg/pkg.sh
. @@LIBDIR@@/pkg/msg.sh

_USAGE='[-v[v] [-p root_prefix] name ...'

VERBOSE=0

while getopts "p:v" opt; do
  case $opt in
    p)
      PREFIX=$OPTARG
      ;;
    v)
      VERBOSE=$(($VERBOSE + 1))
      ;;
  esac
done
unset opt
shift $(( $OPTIND - 1 ))

: ${PREFIX:=/}

case $PREFIX in
  /*)
    :
    ;;
  *)
    usage
    ;;
esac

_changed_err() {
  local f=$1

  err "'$f' local changes, skipping removal"
}

_rm_empty_dirs() {
  local f=$1
  local d

  d=${f%/*}
  while [ "$d" ]; do
    if rmdir $d 2>/dev/null; then
      [ "$VERBOSE" -le 1 ] || printf -- '%s\n' $d
    fi
    d=${d%/*}
  done
}

_rm() {
  local f=$1

  [ "$VERBOSE" -le 1 ] || printf -- '%s\n' $f
  rm $f
}

handle_db_line() {
  local p=$1
  local t=$2
  local m=$3

  case $t in
    f)
      if check_sum $p $m; then
        _rm $p
      else
        _changed_err $p
      fi
      ;;
    l)
      if [ "$(readlink $p)" = $m ]; then
        _rm $p
      else
        _changed_err $p
      fi
      ;;
  esac

  _rm_empty_dirs $p
}

for p; do
  [ "$VERBOSE" -le 0 ] || msg "removing '$p'"
  read_db $PREFIX $p handle_db_line
  rm $(pkg_db $PREFIX $p)
done
unset p
