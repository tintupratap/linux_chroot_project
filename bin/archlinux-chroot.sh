export MY_CHROOT=/opt/Linux-Distros/arch/
export ARCH=x86_64
umount_chroot_archlinux()
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
mount_chroot_archlinux()
{
	echo "	Chroot directory is $MY_CHROOT"
        if [[ $(findmnt -M $MY_CHROOT/proc) ]]; then
                echo "	Already mounted, use 'sudo $0 start' to start chroot..."
        else
                echo "	Mounting..."
		mount --bind /proc $MY_CHROOT/proc
	        mount --bind /sys $MY_CHROOT/sys
	        mount --bind /dev $MY_CHROOT/dev
	        mount --bind /dev/pts $MY_CHROOT/dev/pts
	        #mount proc $MY_CHROOT/proc -t proc
	        #mount sysfs $MY_CHROOT/sys -t sysfs
		echo "	Successfully mounted, use 'sudo $0 start' to start chroot..."
	fi
}
start_chroot_archlinux()
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
			mount_chroot_archlinux
			echo "	Successfully mounted, continuing to chroot..."
			start_chroot_archlinux
		fi
	fi


}

if [ "$*" == "" ]; then
	echo "	Usage: 'sudo $0 start|mount|umount'" 
  	exit 1
fi
if [ $1 = "help" ]; then
	echo "	Usage: 'sudo $0 start|mount|umount'" 
	exit 1
fi
if [ $1 = "umount" ]; then
	umount_chroot_archlinux
	exit 0
fi

if [ $1 = "mount" ]; then
	mount_chroot_archlinux
	exit 0
fi
if [ $1 = "start" ]; then
	start_chroot_archlinux
	exit 0
fi
