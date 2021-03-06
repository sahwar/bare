inherit linux

pre_configure() {
	cat <<-EOF >.config
	CONFIG_SYSVIPC=y
	CONFIG_SMP=y
	CONFIG_NET=y
	CONFIG_PACKET=y
	CONFIG_UNIX=y
	CONFIG_INET=y
	CONFIG_BLK_DEV_SD=y
	CONFIG_ATA=y
	CONFIG_ATA_PIIX=y
	CONFIG_ATA_SFF=y
	CONFIG_SATA_AHCI=y
	CONFIG_NETDEVICES=y
	CONFIG_NE2K_PCI=y
	CONFIG_8139CP=y
	CONFIG_INPUT_EVDEV=y
	CONFIG_SERIAL_8250=y
	CONFIG_SERIAL_8250_CONSOLE=y
	CONFIG_EXT4_FS=y
	CONFIG_TMPFS=y
	CONFIG_TMPFS_POSIX_ACL=y
	EOF
}
