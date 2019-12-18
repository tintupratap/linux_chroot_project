CHROOTDEST=/opt/Linux-Distros/arch/

bash ./arch/bootstrap.sh $CHROOTDEST

bash ./arch/post-install.sh

install -m 755 bin/archlinux-chroot.sh /usr/local/bin/archlinux-chroot

echo "Use 'sudo /usr/local/bin/archlinux-chroot start' to start the installed ArchLinux"

