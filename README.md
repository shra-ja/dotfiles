# dotfiles
Personal dotfiles repository using GNU Stow.

## Usage
### Checkout
Simply check out the repository to your desired location. However, I recommend checking out the repo to your home directory (i.e. $HOME/dotfiles) as GNU Stow targets the parent directory by default.

### Package Installation
#### WSL/Ubuntu
Install all Ubuntu packages with:
```console
> cd apt
> xargs -a <(awk '! /^ *(#|$)/' "packages.list") -r -- sudo apt install -y
```

#### MacOS
Install all Homebrew packages with:
```console
> cd homebrew
> brew bundle install
```

### Shell Setup
Use GNU Stow to set up all other folders
```console
> stow asdf fsh iterm2 zsh
```

By default, GNU Stow targets the parent directory by default but if you checked out to a different directory then you will need to add an addition target argument:
```console
> stow -t ~ asdf fsh iterm2 zsh
```

## Repo Structure
### Stow
GNU Stow is a symlinking tool that takes the contents of a "package" and creates symlinks for all files within the directory in the parent directory.

For example, given a package `someName` with a file `someFile.txt` located at:
```
someName/someSubDir/someFile.txt
```
A symlink will be created to this file at:
```
../someSubDir/someFile.txt
```
By mimicking the expected structure of your home directory within a Stow package, you can target the home directory and create symlinks for files there to a more managed location.

This is the approach taken for the `.zshrc` file for the shell in this repo. The zsh package contains a .zshenv at the top level that changes the default location of the zshrc file and other associated zsh files (to avoid cluttering the home directory directly) and the zshrc file is located within the corresponding subfolder.
```console
> ls -la
.zshenv -> dotfiles/zsh/.zshenv
> ls -la .config/zsh
.zshrc -> dotfiles/zsh/.config/zsh/.zshrc
```

### Private dotfiles
You can create a similar repo for any dotfiles you wish to manage yourself. The zshrc in this repo will automatically source the contents of $HOME/config/zsh-private/.zshrc so you can have a private stow package named zsh-private containing any shell overrides that you require on top of what is in this repo.
