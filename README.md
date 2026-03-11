# MY DOTFILES 

- these are all my janky lil dotfiles
- they're being managed with stow and git

## FILES BEING MANGED

| FILE       | DESCRIPTION                 |
|------------|-----------------------------|
| .bashrc    | terminal look and shortcuts |
| .xinitrc   | xorg config                 |
| .xprofile  | other random stuff          |
| .zen       | browser profiles            |
| .config    | app config files            |
| .local/bin | custom commands             |


## HOW TO

- couple handful of commands to help with managing the dotfiles

### ADDING FILES TO STOW & GITHUB

run code below:
```
cp ~/path/to/new/file ~/.dotfiles/path/to/new/file # copy files to .dotfiles
cd ~/.dotfiles # move into .dotfiles
stow --adopt . # remake all the symlinks with stow
git add . # add all files to commit
git commit -m "message" # commit the files
git push # push the files to GitHub
```
