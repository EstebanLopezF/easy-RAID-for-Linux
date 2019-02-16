#!/bin/bash

numberOfDisks=2
sizeOfDisksGB=2GB
raidLevel=0
deviceName=md127
mountPoint=/data
part=(a b c d e f g h i j k l m n o p q r s t u v w x y z);
fileSystem=ext4

for (( COUNT=1 ; COUNT <= $numberOfDisks ; COUNT++ )) ; do
	parted --script /dev/sd${part[$COUNT]} "mklabel gpt mkpart primary 1MiB $sizeOfDisksGB"
done;

for (( COUNT2=1 ; COUNT2 <= $numberOfDisks ; COUNT2++ )) ; do
	while [ ! -e "/dev/sd${part[$COUNT2]}" ]; do sleep 1; done
done;

mdadm --create $deviceName --level $raidLevel --raid-devices $numberOfDisks /dev/sdb1 /dev/sdc1
mkfs -t $fileSystem /dev/$deviceName
mkdir $mountPoint

uuid=$(blkid -o value -s UUID /dev/$deviceName)
echo "UUID=$uuid     $mountPoint   $fileSystem    defaults,discard,nofail        0 2" >> /etc/fstab
mount -a

echo "bootdegraded=true" >> /etc/default/grub
cp -a /boot/grub2/grub.cfg /boot/grub2/grub.cfg.bak
grub2-mkconfig -o /boot/grub2/grub.cfg
