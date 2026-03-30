# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Basic aliases and prompt
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# terminal prompt (looks like `(my_stuff)> ` when in $HOME/my_stuff)
PS1="(\W)> "

# see if ecrypted is decrypted
source "$HOME/.local/bin/is-encrypted.sh"

# global vars
export TERMINAL=kitty
export EDITOR=nvim
export FITBIT_NO_KEYCHAIN=1 # used for disabling fitbit keyring? idek idc
# for nvim grammer checker
export JAVA_TOOL_OPTIONS="-Djdk.xml.totalEntitySizeLimit=0"

# inits nvm
export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/init-nvm.sh

# global vars
source "$HOME/.bash_env"

# PATH for local binaries
export PATH="$HOME/.local/bin:$PATH:/home/noah/.local/bin"

# GPG terminal fix
export GPG_TTY=$(tty)

# App aliases
alias ra='ranger'
alias vim='nvim'
alias reg-vim='vim'
#alias zen="zen-browser"
alias r="./.bi"
alias x="startx"
alias git-conf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# wrappers

li() { ranger "$HOME/my_stuff/Documents" --cmd="set show_hidden false"; }

j() { ranger "$LOGS"; }

# bluetooth reset function
bt-reset() {
    {
        echo "remove 70:37:3F:56:4D:B0"
        echo "power off"
        sleep 1
        echo "power on"
        sleep 1
        echo "agent on"
        echo "default-agent"
        sleep 1
        echo "scan on"
        sleep 10
        echo "trust 70:37:3F:56:4D:B0"
        echo "connect 70:37:3F:56:4D:B0"
        sleep 10
    } | bluetoothctl
}

# sleeping function
sp() {
    source "$HOME/.local/bin/lock"
    sleep 3
    systemctl suspend
}

