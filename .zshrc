source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", as:plugin, defer:2
zplug "zplug/zplug", hook-build:'zplug --self-manage', as:plugin
zplug "agnoster/agnoster-zsh-theme", as:theme
zplug load

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

setopt CORRECT            # Correct commands
setopt COMPLETE_IN_WORD   # Complete from both ends of a word.
setopt ALWAYS_TO_END      # Move cursor to the end of a completed word.
setopt PATH_DIRS          # Perform path search even on command names with slashes.
setopt AUTO_MENU          # Show completion menu on a successive tab press.
setopt AUTO_LIST          # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH   # If completed parameter is a directory, add a trailing slash.
unsetopt MENU_COMPLETE    # Do not autoselect the first completion entry.

# coloring completion
eval "$(dircolors --sh)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _expand _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' menu select
setopt MENU_COMPLETE
zmodload zsh/complist

# Use hjkl in completion menu.
bindkey -M menuselect '^n' vi-down-line-or-history
bindkey -M menuselect '^p' vi-up-line-or-history
#bindkey -M menuselect 'H' vi-backward-char
#bindkey -M menuselect 'L' vi-forward-char
bindkey -M menuselect '^k' accept-line
bindkey -M menuselect '^h' backward-delete-char


alias vim='nvim'
alias vimdiff="nvim -d"
alias gdb='gdb -q'
alias gst='git status'
alias ga='git add'
alias tig='tig --all'
alias ls='ls --group-directories-first --color=auto'
alias la="${aliases[ls]:-ls} -al"
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

export EDITOR='nvim'
export VISUAL='nvim'

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dsun.java2d.opengl=true'
#export _JAVA_AWT_WM_NONREPARENTING=1
#export JAVA_FONTS=/usr/share/fonts/TTF
export RUST_SRC_PATH='/usr/local/src/rustc/src'
export PATH=$PATH:/usr/local/lib
export PATH=$PATH:~/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

bindkey -v
bindkey -M vicmd "H" vi-first-non-blank
bindkey -M vicmd "L" vi-end-of-line
bindkey -M vicmd "/" vi-history-search-backward
bindkey -M vicmd "n" vi-repeat-search
bindkey -M vicmd "N" vi-rev-repeat-search
