export MY_CHROOT=/opt/debian/sid-root
export ARCH=amd64
export BRANCH=sid
umount_chroot_debian()
{
	if [[ $(findmnt -M $MY_CHROOT/proc) ]]; then
		echo "	Umounting all from $MY_CHROOT..."
		umount $MY_CHROOT/proc
		umount $MY_CHROOT/sys
        	umount $MY_CHROOT/dev/pts
        	umount $MY_CHROOT/dev
		echo "	Successfully umounted..."
        else
                echo "	Not mounted, nothing to do..."
        fi
}
mount_chroot_debian()
{
	echo "	Chroot directory is $MY_CHROOT"
        if [[ $(findmnt -M $MY_CHROOT/proc) ]]; then
                echo "	Already mounted, use '$0 start' to start chroot..."
        else
                echo "	Mounting..."
		mount --bind /proc $MY_CHROOT/proc
	        mount --bind /sys $MY_CHROOT/sys
	        mount --bind /dev $MY_CHROOT/dev
	        mount --bind /dev/pts $MY_CHROOT/dev/pts
	        #mount proc $MY_CHROOT/proc -t proc
	        #mount sysfs $MY_CHROOT/sys -t sysfs
		echo "	Successfully mounted, use '$0 start' to start chroot..."
	fi
}
start_chroot_debian()
{
	echo "	Chroot directory is $MY_CHROOT"
        if [[ $(findmnt -M $MY_CHROOT/proc) ]]; then
                echo "	Already mounted..."
                echo "	Entering chroot $MY_CHROOT..."
		echo "	Copying resolv.conf, hosts & mtab to chroot for workaround..."
		cp /etc/hosts $MY_CHROOT/etc/hosts
		cp /etc/resolv.conf $MY_CHROOT/etc/resolv.conf
		cp /proc/mounts $MY_CHROOT/etc/mtab
		echo "	Now entering chroot..."
		chroot $MY_CHROOT /bin/bash
	else
		if [ -d $MY_CHROOT ]; then
			echo "	Not mounted, mounting..."
			mount_chroot_debian
			echo "	Successfully mounted, continuing to chroot..."
			start_chroot_debian
		else
			echo "	Installing/bootstrapping into chroot $MY_CHROOT"
			install_chroot_debian
		fi
	fi


}
install_chroot_debian()
{
	if [ -d $MY_CHROOT ]; then
		echo "	Directory '$MY_CHROOT' already found, Already installed?"
		echo "	Chroot doesn't start or broken? Remove '$MY_CHROOT' manually and retry"
	else
		mkdir $MY_CHROOT
		debootstrap --arch $ARCH $BRANCH $MY_CHROOT http://deb.debian.org/debian/
		echo "	Completed..."
		echo "	use '$0 start' to start chroot..."
		echo "	use '$0 mount' to mount chroot..."
		echo "	use '$0 umount' to umount chroot..."
		echo "	use '$0 uninstall' to uninstall chroot..."
	fi
}
uninstall_chroot_debian()
{
	cd /
	if [ -d $MY_CHROOT ]; then
		echo "	You are trying to uninstall chroot..."
		umount_chroot_debian
		echo "	Removing $MY_CHROOT?"
		rm -rf $MY_CHROOT
		echo "	Succesfully uninstalled..."
		echo "	use '$0 install' to install chroot again..."
	else
		echo "	Chroot not installed in $MY_CHROOT, nothing to do..."
	fi

}




if [ $1 = "umount" ]; then
	umount_chroot_debian
	exit 0
fi

if [ $1 = "mount" ]; then
	mount_chroot_debian
	exit 0
fi
if [ $1 = "start" ]; then
	start_chroot_debian
	exit 0
fi
if [ $1 = "install" ]; then
        install_chroot_debian
        exit 0
fi
if [ $1 = "uninstall" ]; then
        uninstall_chroot_debian
        exit 0
fi

