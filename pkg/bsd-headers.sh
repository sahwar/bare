ver 1.0
epoc 1

builddir .

do_install() {
	install -Dm644 $MK_FILE/sys-cdefs.h \
		$MK_DESTDIR$MK_PREFIX/include/sys/cdefs.h
}
