#after arch-chroot
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc --utc
echo -e "en_US.UTF-8 UTF-8\nja_JP.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
#echo KEYMAP=us > /etc/vconsole.conf
localectl set-keymap --no-convert us
mkinitcpio -P
passwd
#intel
#pacman -S intel-ucode
bootctl --path=/boot install
echo \
"default arch
timeout 3
editor no" > /boot/loader/loader.conf
lsblk
ls -l /dev/disk/by-partuuid
echo "root PARTUUID?"
read ruuid
echo \
"title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=PARTUUID=$ruuid rw" > /boot/loader/entries/arch.conf

systemctl enable systemd-networkd systemd-resolved sudo neovim
EDITOR=nvim
pacman -S zsh lsb-release
echo "What's your name?"
read name
useradd -m -G wheel -s /bin/zsh $name
passwd $name
echo "opening visudo..."
read _
visudo
