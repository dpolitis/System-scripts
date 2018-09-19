#!/bin/bash

cd /tmp
sudo yum install -y curl rsync isomd5sum genisoimage

curl -RO http://ftp.ntua.gr/pub/linux/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-1804.iso

sudo mkdir /media/mydrive
sudo mount -o loop CentOS-7-x86_64-NetInstall-1804.iso /media/mydrive

sudo mkdir -p /var/tmp/media/mydrive
sudo rsync -av /media/mydrive/ /var/tmp/media/mydrive/
sudo umount /media/mydrive

sudo cp /home/vagrant/ks.cfg /var/tmp/media/mydrive/ks.cfg

sudo sed -i 's/64 quiet/64 quiet inst.text inst.ks=cdrom\:\/dev\/cdrom\:\/ks.cfg net.ifnames=0 biosdevname=0/g' /var/tmp/media/mydrive/isolinux/isolinux.cfg
sudo sed -i 's/64 quiet/64 quiet inst.text inst.ks=cdrom\:\/ks.cfg net.ifnames=0 biosdevname=0/g' /var/tmp/media/mydrive/EFI/BOOT/grub.cfg
sudo sed -i 's/check quiet/check quiet inst.text inst.ks=cdrom\:\/ks.cfg net.ifnames=0 biosdevname=0/g' /var/tmp/media/mydrive/EFI/BOOT/grub.cfg
sudo sed -i 's/set quiet/set quiet inst.text inst.ks=cdrom\:\/ks.cfg net.ifnames=0 biosdevname=0/g' /var/tmp/media/mydrive/EFI/BOOT/grub.cfg
sudo sed -i 's/default="1"/default="0"/g' /var/tmp/media/mydrive/EFI/BOOT/grub.cfg

cd /var/tmp/media/mydrive
sudo genisoimage -o /tmp/CentOS-7-x86_64-NetInstall-1804_ks_mbr.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -v -T -V 'CentOS 7 x86_64' .
sudo genisoimage -o /tmp/CentOS-7-x86_64-NetInstall-1804_ks_efi.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -J -R -v -T -V 'CentOS 7 x86_64' .

cd /tmp
sudo implantisomd5 /tmp/CentOS-7-x86_64-NetInstall-1804_ks_mbr.iso
sudo implantisomd5 /tmp/CentOS-7-x86_64-NetInstall-1804_ks_efi.iso

sudo isohybrid /tmp/CentOS-7-x86_64-NetInstall-1804_ks_mbr.iso
sudo isohybrid --uefi /tmp/CentOS-7-x86_64-NetInstall-1804_ks_efi.iso

sudo rm -rf /var/tmp/media /media/mydrive /tmp/CentOS-7-x86_64-NetInstall-1804.iso
