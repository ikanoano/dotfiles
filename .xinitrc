export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export XMODIFIER="@im=fcitx"
export DefaultIMModule=fcitx
export XKB_DEFAULT_LAYOUT=us
setxkbmap -layout us
exec i3
