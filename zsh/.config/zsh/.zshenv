typeset -U path PATH  # Always remove duplicates from PATH

[[ ! -f "$HOME/.cargo/env" ]] || source "$HOME/.cargo/env"
