

# Backing up `dotfile`s using a `--bare` repo

## Storing `dotfile`s using a `--bare` repository

```
git init --bare $HOME/dotfiles
alias dotcfg='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
dotcfg config --local status.showUntrackedFiles no
dotcfg add .bashrc .profile .fzf-marks .zshenv .config .local .zsh
dotcfg commit -m "testing bare"
dotcfg branch -M main
dotcfg remote add origin https://mojolo@github.com/mojolo/tstng.git
dotcfg push -u origin main
```

## Installing `dotfile`s on a new sys using a `--bare` repo

```
touch $HOME/.gitignore
echo ".dotcfg" >> $HOME/.gitignore
git clone --bare https://mojolo@github.com/mojolo/tstng.git $HOME/.dotcfg
alias dotcfg='/usr/bin/git --git-dir=$HOME/.dotcfg/ --work-tree=$HOME'
dotcfg config --local status.showUntrackedFiles no
dotcfg checkout
```



---

# ~~Backing up `dotfile`s using a default repo~~

## ~~Storing `dotfile`s using a default repo~~

```bash
git init $HOME/dotfiles
alias dotcfg='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME'
# dotcfg config --local status.showUntrackedFiles no
dotcfg add .bashrc .profile .fzf-marks .zshenv .config .local .zsh
dotcfg commit -m "testing default repo"
dotcfg branch -M main
dotcfg remote add origin https://mojolo@github.com/mojolo/tstng.git
dotcfg push -u origin main
```

## ~~Installing `dotfile`s on a new sys using a default repo~~

```
touch $HOME_DOT/.gitignore
echo ".dotcfg" >> $HOME_DOT/.gitignore
git clone https://mojolo@github.com/mojolo/tstng.git $HOME_DOT/.dotcfg
alias dotcfg='/usr/bin/git --git-dir=$HOME_DOT/.dotcfg/.git --work-tree=$HOME_DOT'
dotcfg config --local status.showUntrackedFiles no
dotcfg checkout
```

