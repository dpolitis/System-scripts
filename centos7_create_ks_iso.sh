#!/bin/bash

cd /tmp
sudo yum install -y curl rsync syslinux

curl -RO http://ftp.ntua.gr/pub/linux/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-1804.iso

sudo mkdir /media/{BOOT,DATA,DVD}
sudo parted --script /dev/sdb \
	mklabel msdos \
	mkpart primary fat32    1MiB       250MiB \
	mkpart primary ext4    250MiB       -1MiB \
	set 1 boot on

sudo mkfs -t vfat -n "BOOT" /dev/sdb1
sudo mkfs -L "DATA" /dev/sdb2

sudo syslinux --directory syslinux --install /dev/sdb1
sudo dd conv=notrunc bs=440 count=1 if=/usr/share/syslinux/mbr.bin of=/dev/sdb

sudo mount -o loop CentOS-7-x86_64-NetInstall-1804.iso /media/DVD
sudo mount /dev/sdb1 /media/BOOT
sudo mount /dev/sdb2 /media/DATA

sudo rsync -av /media/DVD/isolinux /media/BOOT
sudo mv /media/BOOT/isolinux/isolinux.cfg /media/BOOT/syslinux/syslinux.cfg
sudo cp /media/BOOT/isolinux/{boot.cat,boot.msg,initrd.img,memtest,splash.png,vmlinuz} /media/BOOT/syslinux/
sudo cp /usr/share/syslinux/vesamenu.c32 /media/BOOT/syslinux/

sudo rm -rf /media/BOOT/isolinux

sudo cp /home/vagrant/ks.cfg /media/BOOT/syslinux/ks.cfg
sudo cp /tmp/CentOS-7-x86_64-NetInstall-1804.iso /media/DATA/

sudo sed -i 's/CentOS\\x207\\x20x86_64 quiet/DATA:\/ quiet inst.text inst.ks=hd:LABEL=BOOT:/syslinux/ks.cfg net.ifnames=0 biosdevname=0/g' /media/BOOT/syslinux/syslinux.cfg

sudo umount /media/{BOOT,DATA,DVD}
sudo rm -rf /media/{BOOT,DATA,DVD} /tmp/CentOS-7-x86_64-NetInstall-1804.iso
