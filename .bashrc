# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Basic aliases and prompt
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# terminal prompt
PS1="[\W]> "

# for nvim grammer checker
export JAVA_TOOL_OPTIONS="-Djdk.xml.totalEntitySizeLimit=0"

# global vars
source "$HOME/.bash_env"

# PATH for local binaries
export PATH="$HOME/.local/bin:$PATH:/home/noah/.local/bin"

# Korean IME
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# App aliases
alias ra='ranger'
alias vim='nvim'
alias nivm='nvim' # i keep fucking doing this
alias reg-vim='vim'
alias r="./.bi"
alias x="startx"
alias g="$HOME/.local/bin/git-script"


li() { "$FILE_MGR" "$HOME/my_stuff/Documents" --cmd="set show_hidden false"; }

# sleep cmd
sp() {
    slock &
    sleep 0.2
    systemctl suspend
}
