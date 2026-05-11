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

# App aliases
alias ra='ranger'
alias vim='nvim'
alias nivm='nvim' # i keep fucking doing this
alias reg-vim='vim'
alias r="./.bi"
alias x="startx"
alias g="$HOME/.local/bin/git-script"

# wrappers

li() { "$FILE_MGR" "$HOME/my_stuff/Documents" --cmd="set show_hidden false"; }

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

