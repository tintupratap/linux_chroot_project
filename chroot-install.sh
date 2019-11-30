export CHROOTDEST=/opt/Linux-Distros/
export INSTALLBIN=/usr/local/bin
export ARCH=$(uname -m)
install_archlinux()
{

bash ./arch/arch-bootstrap.sh --arch=$ARCH $CHROOTDEST/arch

bash ./arch/post-install.sh

install -m 755 bin/archlinux-chroot.sh $INSTALLBIN/archlinux-chroot

echo "Use 'sudo /usr/local/bin/archlinux-chroot start' to start the installed ArchLinux"

}
install_debian()
{
#fix wrong architecture for debootstrap 
if [ $ARCH == "x86_64" ]; then
	ARCH=amd64
fi

bash ./debian/debootstrap --arch=$ARCH  $CHROOTDEST/debian

}



if [ "$*" == "" ]; then
	echo "	Usage: 'sudo $0 arch|debian'" 
  	exit 1
fi
if [ $1 = "help" ]; then
	echo "	Usage: 'sudo $0 arch|debian'" 
	exit 1
fi
if [ $1 = "arch" ]; then
	install_archlinux
	exit 0
fi

if [ $1 = "debian" ]; then
	install_debian
	exit 0
fi
if [ $1 = "others" ]; then
	echo "Kali (coming soon)"
	echo "Ubuntu (coming soon)"
	echo "Gentoo (coming soon)"
	echo "Alpine (coming soon)"
	echo "Void (coming soon)"
	echo "Fedora (coming soon)"
	exit 0
fi
