pkg_to_fullname() {
  local pkg=$1

  printf -- '%s' ${pkg%$PKG_EXT*}
}

pkg_to_name() {
  local pkg=$1

  printf -- '%s' ${pkg%-*}
}

pkg_to_version() {
  local pkg=$1
  local fullname=$(pkg_to_fullname $pkg)

  printf -- '%s' ${fullname##*-}
}

pkg_db() {
  local prefix=$1
  local name=$2

  printf -- '%s' ${prefix%/}/$PKG_DB/$name
}

pkg_installed() {
  local prefix=$1
  local name=$2

  [ -f $(pkg_db $prefix $name) ]
}

read_repo() {
  local repo=$1
  local cb=$2

  [ -d $repo ] || die "unable to read repo: '$REPO'"

  local f p
  for f in $repo/*$PKG_EXT; do
    p=$(basename $f)
    $cb $(pkg_to_name $p) $(pkg_to_version $p) $(pkg_to_fullname $p) $p
  done
}

read_db() {
  local prefix=$1
  local name=$2
  local cb=$3
  local db=$(pkg_db $prefix $name)

  [ -f $db ] || die "unable to read '$name' ($db)"

  local f p t m
  while IFS='|' read -r f t m; do
    p=$prefix$f
    $cb $p $t $m
  done < $db
}

file_sum() {
  local f=$1

  sha512sum $f | cut -d' ' -f1
}

check_sum() {
  local f=$1
  local sum=$2

  [ $(file_sum $f) = $sum ]
}
