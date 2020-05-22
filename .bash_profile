#!/bin/bash

if [[ $(which ansible) != "" ]]; then
  export ANSIBLE_HOST_KEY_CHECKING=false
  export ANSIBLE_FORCE_COLOR=true
fi

if [[ $(which go) != "" ]]; then
  export GOPATH="$HOME/go"
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
