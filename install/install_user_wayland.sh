#!/bin/zsh
set -x
pushd

sudo pacman -Syu

sudo sed -i -e "s/^#Color/Color/g" /etc/pacman.conf

# ease of installation
sudo pacman -S --needed nftables wget openssh
sudo systemctl enable --now nftables
sudo sh -c \
"\"[Match]
Name=enp1s0

[Network]
DHCP=ipv4\"" > /etc/systemd/network/20-wired.network
sudo systemctl restart systemd-networkd
ip address
sudo systemctl enable --now sshd
  # you can connect to sshd until nftables is started

# install trizen
cd /tmp
wget -nc https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz
tar -xvf trizen.tar.gz
cd trizen
makepkg -si --needed

# wayland
sudo pacman -S --needed sway dmenu alacritty xorg-xwayland

# sound
sudo pacman -S --needed alsa-utils pulseaudio-alsa pavucontrol

# network 1/2
sudo pacman -S --needed iputils networkmanager network-manager-applet net-tools dnscrypt-proxy nftables
sudo systemctl enable nftables # not --now

# dev
sudo pacman -S --needed git tig neovim python-neovim diff-so-fancy
export EDITOR=nvim
export VISUAL=nvim
# util
sudo pacman -S --needed unzip htop cpupower
#sudo pacman -S --needed udisks2 udevil
# input
sudo pacman -S --needed fcitx-kkc fcitx-configtool
# app
sudo pacman -S --needed firefox thunderbird


export DOTFILES=${HOME}/repos/dotfiles
mkdir -p `dirname ${DOTFILES}`
git clone --depth=1 https://github.com/ikanoano/dotfiles.git ${DOTFILES}

export ZPLUG_HOME=${HOME}/.zplug
git clone --depth=1 https://github.com/zplug/zplug ${ZPLUG_HOME}
source ${ZPLUG_HOME}/init.zsh
zplug install

setopt EXTENDED_GLOB
# copy all files under $DOTFILES preserving symbolic link, except .git/
cp -asf ${DOTFILES}/^.git(D) ${HOME}/
# ${HOME}/install/ is not used. remove manually (tehe)
xrdb -merge ${HOME}/.Xresources

export DEINIT=/tmp/installer.sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${DEINIT}
sh ${DEINIT} ${HOME}/.config/nvim/dein

# util
trizen -S --needed systemd-boot-pacman-hook
# font
trizen -S --needed ttf-cica otf-inconsolata-powerline-git ttf-symbola noto-fonts-emoji
# app
trizen -S --needed profile-sync-daemon universal-ctags-git

#echo "add \"${USER} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper\" to sudoers." | tee /tmp/memo
#read _
#sudo visudo
#systemctl --user enable --now psd
#
sudo sh -c \
"echo \"HandlePowerKey=suspend
HandleHibernateKey=suspend
HandleLidSwitch=suspend\" >> /etc/systemd/logind.conf"

# cpu
sudo sh -c \
"echo \"governor='powersave'\" >> /etc/default/cpupower"
sudo systemctl enable --now cpupower.service

## ssd
#sudo systemctl enable --now fstrim.timer
#sudo sed -i "s/relatime/noatime/g" /etc/fstab

#sudo sh -c \
#"echo \"LANG=ja_JP.UTF-8\" > /etc/locale.conf"
#sudo localectl set-locale LANG=ja_JP.UTF-8
#sudo localectl set-x11-keymap us

# network 2/2
sudo systemctl disable --now systemd-networkd
#sudo rm /etc/systemd/network/wired.network
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now dnscrypt-proxy.service
sudo cp -asf ${DOTFILES}/install/dnscrypt-proxy.toml /etc/dnscrypt-proxy/

# mouse/keyboard
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp -asf ${DOTFILES}/install/50-mouse-noaccel.conf /etc/X11/xorg.conf.d/

sudo systemctl enable lightdm

## mount
#sudo chmod -s /usr/bin/udevil
#sudo cp -asf ${DOTFILES}/install/50-udisks.rules /etc/polkit-1/rules.d/
#sudo systemctl enable --now devmon@${USER}.service

# ntp
sudo cp -asf ${DOTFILES}/install/ntp.conf /etc
sudo systemctl enable ntpdate.service

#sudo reboot
popd
set +x
