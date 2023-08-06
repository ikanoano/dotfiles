source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", as:plugin, defer:2
zplug "zplug/zplug", hook-build:'zplug --self-manage', as:plugin
zplug "agnoster/agnoster-zsh-theme", as:theme
zplug "junegunn/fzf", \
    from:gh-r, \
    as:command, \
    use:"*linux*amd64*"
zplug load

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

setopt CORRECT            # Correct commands
unsetopt CORRECT_ALL
setopt COMPLETE_IN_WORD   # Complete from both ends of a word.
setopt ALWAYS_TO_END      # Move cursor to the end of a completed word.
setopt PATH_DIRS          # Perform path search even on command names with slashes.
setopt AUTO_MENU          # Show completion menu on a successive tab press.
setopt AUTO_LIST          # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH   # If completed parameter is a directory, add a trailing slash.
setopt MENU_COMPLETE
setopt MAGIC_EQUAL_SUBST

# coloring completion
eval "$(dircolors --sh)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _expand _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 3 numeric
zstyle ':completion:*' menu select
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
alias tig='tig --all'
alias ls='ls --group-directories-first --color=auto -h'
alias la="${aliases[ls]:-ls} -al"
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

export EDITOR='nvim'
export VISUAL='nvim'

export PATH=$PATH:/usr/local/lib
export PATH=$PATH:/home/ikanoano/bin
export PATH=$PATH:/home/ikanoano/.cargo/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

bindkey -v
bindkey -r '\e/' # to remove esc -> / lag
bindkey -M vicmd "H" vi-first-non-blank
bindkey -M vicmd "L" vi-end-of-line
bindkey -M vicmd "/" vi-history-search-backward
bindkey -M vicmd "n" vi-repeat-search
bindkey -M vicmd "N" vi-rev-repeat-search
