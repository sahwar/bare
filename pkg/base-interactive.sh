ver 0.0.1
rev 1

rdep \
  base \
  vis \
  mdocml

builddir .

do_install() {
  mkdir -p $MK_DESTDIR
}