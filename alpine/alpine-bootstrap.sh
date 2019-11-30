${chroot_dir} =/opt/Linux-Distros/alpine
${mirror} = http://dl-cdn.alpinelinux.org/alpine/
#########IF MIRROR DONT WORK, CHOOSE AND REPLACE WITH ONE OF THEM BELOW######################
#http://uk.alpinelinux.org/alpine/
#http://dl-2.alpinelinux.org/alpine/
#http://dl-4.alpinelinux.org/alpine/
#http://dl-5.alpinelinux.org/alpine/
#http://dl-8.alpinelinux.org/alpine/
#http://mirror.yandex.ru/mirrors/alpine/
#http://mirrors.gigenet.com/alpinelinux/
#http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/
#http://mirror.leaseweb.com/alpine/
#http://mirror.fit.cvut.cz/alpine/
#http://alpine.mirror.far.fi/
#http://alpine.mirror.wearetriple.com/
#http://mirror.clarkson.edu/alpine/
#http://linorg.usp.br/AlpineLinux/
#http://ftp.yzu.edu.tw/Linux/alpine/
#http://mirror.aarnet.edu.au/pub/alpine
#http://speglar.siminn.is/alpine/
#http://mirrors.dotsrc.org/alpine/
#http://ftp.halifax.rwth-aachen.de/alpine/
#http://mirrors.tuna.tsinghua.edu.cn/alpine/
#http://mirrors.ustc.edu.cn/alpine/
#http://mirrors.xjtu.edu.cn/alpine/
#http://mirrors.nju.edu.cn/alpine/
#http://mirror.lzu.edu.cn/alpine/
#http://ftp.acc.umu.se/mirror/alpinelinux.org/
#http://mirror.xtom.com.hk/alpine/
#http://mirror.csclub.uwaterloo.ca/alpine/
#http://alpinelinux.mirror.iweb.com/
#http://mirror.neostrada.nl/alpine/
#http://pkg.adfinis-sygroup.ch/alpine/
#http://mirror.ps.kz/alpine/
#http://mirror.rise.ph/alpine-linux/
#http://mirror.operationtulip.com/alpine/
#http://mirrors.ircam.fr/pub/alpine/
#http://alpine.42.fr/
#http://mirror.math.princeton.edu/pub/alpinelinux/
#http://mirrors.sjtug.sjtu.edu.cn/alpine/
#http://alpine.mirror.didstopia.com/
#http://ftp.icm.edu.pl/pub/Linux/distributions/alpine/
#http://mirror.ungleich.ch/mirror/packages/alpine/
#http://alpine.mirror.vexxhost.ca/
#http://sjc.edge.kernel.org/alpine/
#http://ewr.edge.kernel.org/alpine/
#http://ams.edge.kernel.org/alpine/
#http://download.nus.edu.sg/mirror/alpine/
######################################################################
${arch}=$(uname -m)
${version}=2.10.4-r2
wget ${mirror}/latest-stable/main/${arch}/apk-tools-static-${version}.apk
tar -xzf apk-tools-static-*.apk
./sbin/apk.static -X ${mirror}/latest-stable/main -U --allow-untrusted --root ${chroot_dir} --initdb add alpine-base
