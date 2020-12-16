timedatectl set-ntp true
cgdisk /dev/sda
mkfs.fat -F32 /dev/sda1
mkfs.btrfs -L linux /dev/sda2
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot

pacstrap /mnt base linux linux-firmware btrfs-progs
