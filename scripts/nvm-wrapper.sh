#!/usr/bin/bash

# The purpose of this wrapper script is simply to avoid sourcing
#  the nvm.sh script in my .bashrc. nvm is the node.js version
#  manager. The installation recommends sourcing the nvm.sh script
#  in your .bashrc, which defines the top level nvm() shell function.
#  I instead am placing this executable script on my PATH, which
#  will call the nvm.sh script only when needed.

# node.js version manager installed from: https://github.com/nvm-sh/nvm
NVM_DIR="$HOME/.nvm"

if [ ! "$(type -t nvm)" = 'function' ]; then
    \. "$NVM_DIR/nvm.sh"
fi

# Invoke the nvm() function that has been sourced from nvm.sh.
# Note that this works because shell functions have higher precedence
#  than executables on your PATH.
nvm $@
