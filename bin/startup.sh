#!/bin/bash

# From - https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Assuming we're on a Mac from here on... (sorry Windows devs)
if [ "$(which brew 2>/dev/null)" == "" ]; then
    echo "INSTALLING: `brew`"
    # Install `brew` from - https://brew.sh/
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Setup `brew` paths to help some poor soul who might want to port this
# to a Windows dev environment
INSTALLER=$(which brew)

# Okay, we've got our "installer" installed we'll check or install:
# - Node, Ghost
if [ "$(which ghost 2>/dev/null)" == "" ]; then
    if [ "$(which node 2>/dev/null)" == "" ]; then
	# If not install version 10 that ghost blog requires
	echo "INSTALLING: `node`"
	${INSTALLER} install node@10
	NODE="$(which node)"
	NPM="$(which npm)"
    # If node *is* installed but not v10 exactly...
    elif [ "$(node --version | cut -d'.' -f1 | cut -c2-)" != "10" ]; then
	echo "INSTALLING: `node@10`"
	${INSTALLER} install node@10
	INSTALL_PREFIX="$(brew config | grep HOMEBREW_PREFIX | cut -d' ' -f2)"
	NODE10="${INSTALL_PREFIX}/opt/node@10/bin"
	NODE="${NODE10}/node"
	NPM="${NODE10}/npm"
    else
	NODE="$(which node)"
	NPM="$(which npm)"
    fi

    # Install ghost CLI
    echo "INSTALLING: `ghost`"
    ${NPM} install ghost-cli@latest -g
fi

WEBSITE_DIR="www"

cd ${DIR}/..
mkdir "${WEBSITE_DIR}"
cd "${WEBSITE_DIR}"
ghost install local
