ver 4.9.2
rev 1
dist \
  $URI_GNU/$PKG_NAME/$PKG_NAME-$PKG_VER/$PKG_NAME-${PKG_VER}.tar.bz2 \
  $URI_BB/GregorR/musl-cross/raw/a945614feb1e213411728cf52d8813c966691e14/patches/$PKG_NAME-$PKG_VER-musl.diff

bdep mpc-bld

configure \
  --disable-libsanitizer \
  --disable-libstdcxx-pch \
  --disable-multilib \
  --disable-nls \
  --enable-checking=release \
  --enable-languages=c,c++,lto \
  --enable-lto \
  --enable-shared \
  --libdir=/usr/lib \
  --build=$MK_BUILD_TRIPLE \
  --host=$MK_HOST_TRIPLE \
  --target=$MK_TARGET_TRIPLE

builddir gcc-build

# configure detects max_cmd_len=512 without getconf and the
# libtool code to split long command lines is utterly broken.
export lt_cv_sys_max_cmd_len=8192
