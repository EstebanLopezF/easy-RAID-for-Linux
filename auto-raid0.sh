#!/bin/bash
#creates a RAID 0 using 8x4TB data disks and mount it in /data with fstab entry

parted --script /dev/sdc 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdd 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sde 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdf 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdg 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdh 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdi 'mklabel gpt mkpart primary 1MiB 4000GiB'
parted --script /dev/sdj 'mklabel gpt mkpart primary 1MiB 4000GiB'

while [ ! -e "/dev/sdc1" ]; do sleep 1; done
while [ ! -e "/dev/sdd1" ]; do sleep 1; done
while [ ! -e "/dev/sde1" ]; do sleep 1; done
while [ ! -e "/dev/sdf1" ]; do sleep 1; done
while [ ! -e "/dev/sdg1" ]; do sleep 1; done
while [ ! -e "/dev/sdh1" ]; do sleep 1; done
while [ ! -e "/dev/sdi1" ]; do sleep 1; done
while [ ! -e "/dev/sdj1" ]; do sleep 1; done

mdadm --create /dev/md127 --level 0 --raid-devices 8 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1 /dev/sdi1 /dev/sdj1

mkfs -t ext4 /dev/md127

mkdir /data

uuid=$(blkid -o value -s UUID /dev/md127)
echo "UUID=$uuid     /data   ext4    defaults,discard        0       2" >> /etc/fstab
mount -a
echo "bootdegraded=true" >> /etc/default/grub

exit 0;
