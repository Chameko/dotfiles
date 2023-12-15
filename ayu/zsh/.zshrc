export PATH=$PATH:~/.cargo/bin/

# General
autoload -Uz compinit vcs_info add-zsh-hook && compinit

add-zsh-hook precmd vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '<%b%u%c>'

local user_host="%B%(!.%F{#73b8ff}.%F{#feb454})%n@%m%f%b"
local cwd="%B%F{#59c2ff}%~%f%b"

# Prompt theme
PROMPT='%F{#bfbdb6}╭─%f${user_host} ${cwd} %F{#aad94c}${vcs_info_msg_0_}%f
%F{#bfbdb6}╰─%f%B%(!.#.$)%b '
RPROMPT='%F{#e33400}%?↵%f'
