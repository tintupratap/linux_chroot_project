CHROOTDEST=/opt/Linux-Distros/arch
#CHROOTC="LC_ALL=C chroot"
export LC_ALL=C
CHROOTC="chroot"
$CHROOTC $CHROOTDEST /usr/bin/pacman \
--noconfirm -Sy --overwrite "*" \
bash-completion sudo neofetch vi \
which python-pip python-virtualenv \
python-virtualenvwrapper git htop links

$CHROOTC $CHROOTDEST /usr/bin/useradd arch

echo "Password for user 'arch'"

$CHROOTC $CHROOTDEST /usr/bin/passwd arch

echo "arch ALL=(ALL) ALL" >> /opt/Linux-Distros/arch/etc/sudoers

cp ./inside_chroot/root/.bashrc $CHROOTDEST/root/.bashrc

mkdir -p $CHROOTDEST/home/arch/

$CHROOTC $CHROOTDEST /usr/bin/chown arch:arch /home/arch/

cp ./inside_chroot/home/arch/.bashrc $CHROOTDEST/home/arch/.bashrc

echo "Post installation complete"

echo "Now you can login with regualar user 'arch', \
root user is looped back to user 'arch' for safety reasons"
