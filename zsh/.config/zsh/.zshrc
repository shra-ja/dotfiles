# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share

####################################
### Powerlevel10k Instant Prompt ###
####################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

###############
### Exports ###
###############

# Editor
export EDITOR="vim"
export VISUAL="vim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"   # zsh config location
export HISTFILE="$ZDOTDIR/.zhistory"    # History location
export HISTSIZE=10000                   # Maximum events for history in memory
export SAVEHIST=10000                   # Maximum events for history saved to file

# Set GPG_TTY for GPG signing
export GPG_TTY=$TTY

###################
### zsh Options ###
###################

###############
### Aliases ###
###############

###############
### Plugins ###
###############

# Retrieve zcomet if it doesn't already exist (targets .zcomet/bin)
if [[ ! -f ${ZDOTDIR:-${HOME}/.config/zsh}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}/.config/zsh}/.zcomet/bin
fi

# Load zcomet
source ${ZDOTDIR:-${HOME}/.config/zsh}/.zcomet/bin/zcomet.zsh

# Load plugins with zcomet (plugins are cloned to .zcomet/repos)

# Load syntax, auto-suggest, and powerlevel10k last
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet load romkatv/powerlevel10k

# Run compinit
zcomet compinit

#####################
### Powerlevel10k ###
#####################

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
