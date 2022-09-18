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

#################
### Variables ###
#################

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

# fast-syntax-highlighting
FAST_WORK_DIR="$XDG_CONFIG_HOME/fsh"

# zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=(none)
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=(none)
HISTORY_SUBSTRING_SEARCH_PREFIXED=true

###################
### zsh Options ###
###################

# Documentation for options can be found here: https://zsh.sourceforge.io/Doc/Release/Options.html
# Options are grouped according to the documentation
# Prompt options are handled by Powerline10k

# 1. Changing Directories
setopt auto_cd # cd to dir without typing cd

setopt auto_pushd # Auto push cd'd dirs onto stack
setopt pushd_ignore_dups # Dedupe stack
setopt pushd_minus # Flip plus and minus to specify a stack dir by number

# 2. Completion
setopt auto_list # Automatically list choices on an ambiguous completion
setopt auto_menu # Automatically use menu completion after the second tab
unsetopt menu_complete # Do not auto-select the first completion

setopt always_to_end # Move cursor to end if word had a match
setopt complete_in_word # Run completion from the cursor location

# 4. History
setopt extended_history # Records timestamps in history file
setopt hist_expire_dups_first # Delete duplicates first when internal history needs trimming
setopt hist_find_no_dups # Ignore duplicates when searching through the history
setopt hist_ignore_dups # Do not add repeated commands to the history
setopt hist_ignore_space # Do not add commands that start with a space to the history
setopt hist_verify # Show command with history expansion to user before running it
setopt share_history # Share history between shells

# 6. Input/Output
setopt correct # Auto-correct typos in commands
setopt correct_all # Auto-correct typos in arguments

setopt interactive_comments # Allow comments in interactive shells
unsetopt flowcontrol # Disables output flow control via stop/start (Ctrl+S/Ctrl+Q) reclaiming those keybinds

# 7. Job Control
setopt long_list_jobs # Print job notifications in the long format by default

###############
### Aliases ###
###############

# Show all 256 colours
function show-color-palette {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

###################
### Completions ###
###################

# Documentation for completions can be found here: https://zsh.sourceforge.io/Doc/Release/Completion-System.html

# Enable completion menu
zstyle ':completion:*:*:*:*:*' menu select

# Enable completers: expand *. for extensions, then standard completion, then approximate completion for corrections
zstyle ':completion:*' completer _extensions _complete _approximate

# Enable matchers: case-insensitive, then partial word, then substring
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Enable colors for completion entries using LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group results by category
zstyle ':completion:*' group-name ''

# Color group names
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# Reorder completion results for commands
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# Ignore cache for up-to-date results - has a performance impact
zstyle ':completion:*' rehash true

# Add process completion
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USERNAME -o pid,%cpu,cputime,cmd'

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
zcomet load agkozak/zsh-z

# Load syntax, history-substring-search, auto-suggest, and powerlevel10k last
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load zsh-users/zsh-history-substring-search
zcomet load zsh-users/zsh-autosuggestions
zcomet load romkatv/powerlevel10k

# Run compinit
zcomet compinit

#####################
### Powerlevel10k ###
#####################

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

####################
### Key Bindings ###
####################

bindkey "$terminfo[kcuu1]" history-substring-search-up   # Up Arrow
bindkey "$terminfo[kcud1]" history-substring-search-down # Down Arrow
