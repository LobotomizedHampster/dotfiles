source "$HOME/.bash_env"

# screen lock
xset s 240 # idle time before xss-lock is called
xset s noblank # disable old blanking mechanism
xset s noexpose 

# screen locker 
# xss-lock -- "$HOME/.local/bin/lock"
picom --animations -b # compiler
nitrogen --restore & # wallpaper manager
conky & # background widgets


#exec qtile start
exec dwm
