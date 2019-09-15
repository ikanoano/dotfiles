set -x

sudo sed -i -e "s/^#Color/Color/g" /etc/pacman.conf

sudo pacman -S --needed i3 dmenu arandr lightdm lightdm-gtk-greeter scrot xorg-xrdb xorg-xmodmap
sudo pacman -S --needed alsa-utils pulseaudio-alsa
sudo pacman -S --needed git tig neovim python-neovim gcc binutils diff-so-fancy
sudo pacman -S --needed ntfs-3g sshfs unzip

sudo pacman -S --needed xorg-xauth xorg-xhost xorg-xsetroot libvncserver polkit-gnome gnome-keyring
sudo pacman -S --needed fcitx fcitx-configtool fcitx-mozc fcitx-gtk3
sudo pacman -S --needed freerdp remmina htop iputils cpupower networkmanager network-manager-applet net-tools
sudo pacman -S --needed firefox thunderbird zathura zathura-pdf-poppler poppler-data dnscrypt-proxy xclip
sudo pacman -S --needed udisks2 udevil

setopt EXTENDED_GLOB

export ZPLUG_HOME=${HOME}/.zplug
git clone --depth=1 https://github.com/zplug/zplug $ZPLUG_HOME

export DOTFILES=${HOME}/repos/dotfiles
mkdir -p ${DOTFILES}
git clone git@github.com:ikanoano/dotfiles.git
cd ${HOME}
# link all files under $DOTFILES except .git
cp -asf ${DOTFILES}/^.git(D) ./
cd /tmp
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ${HOME}/.config/nvim/dein

xrdb -merge .Xresources

cd /tmp
wget ttps://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gzh
tar -xvf trizen.tar.gz
cd trizen
makepkg -si
cd ${HOME}

trizen -S profile-sync-daemon rxvt-unicode-patched ttf-cica otf-inconsolata-powerline-git ttf-symbola noto-fonts-emoji universal-ctags-git
cd /etc
cd ${HOME}
echo "add \"\$${USER} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper\" to sudoers."
read _
sudo visudo
systemctl --user enable --now psd

sudo sh -c \
"echo \"HandlePowerKey=suspend
HandleHibernateKey=suspend
HandleLidSwitch=suspend\" >> /etc/systemd/logind.conf"

# cpu
sudo sh -c \
"echo \"governor='powersave'\" >> /etc/default/cpupower"
sudo systemctl enable --now cpupower.service

# ssd
sudo systemctl enable --now fstrim.timer
sudo sed -i "s/relatime/noatime/g" /etc/fstab

sudo sh -c \
"echo \"LANG=ja_JP.UTF-8\" > /etc/locale.conf"
sudo localectl set-locale LANG=ja_JP.UTF-8

# network
sudo systemctl disable --now systemd-networkd
#sudo rm /etc/systemd/network/wired.network
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now dnscrypt-proxy.service
sudo cp -asf ${DOTFILES}/install/dnscrypt-proxy.toml /etc/dnscrypt-proxy/

# mouse/keyboard
sudo cp -asf ${DOTFILES}/install/50-mouse-noaccel.conf /etc/X11/xorg.conf.d/

sudo systemctl enable lightdm

# mount
sudo chmod -s /usr/bin/udevil
sudo cp -asf ${DOTFILES}/install/50-udisks.rules /etc/polkit-1/rules.d/
sudo systemctl enable --now devmon@${USER}.service

#sudo reboot
