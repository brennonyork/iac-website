#!/bin/bash

#####
# This script will run and bootstrap an OSX machine with a development
# environment to begin building themes, testing features for the website,
# and generally working with the codebase.
#####

# From - https://stackoverflow.com/a/246128
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

# Source in our constants. We always start our scripts with this :)
source "${ROOT}/bin/constants.sh"

# Assuming we're on a Mac from here on... (sorry Windows devs)
if [ "$(which brew 2>/dev/null)" == "" ]; then
    echo "INSTALLING: `brew`"
    # Install `brew` from - https://brew.sh/
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Setup `brew` paths to help some poor soul who might want to port this
# to a Windows dev environment
INSTALLER=$(which brew)

if [ "$(which node 2>/dev/null)" == "" ]; then
    ${INSTALLER} install node@10
    ${INSTALLER} unlink node
    ${INSTALLER} link --force --overwrite node@10
elif [ "$(node --version | cut -d'.' -f1 | cut -c2-)" != "10" ]; then
    echo "WARNING: About to install `node@10` which needs to change the default version"
    echo "--- Do you wish to proceed? [ y / n ] ---"
    read ANS
    if [ "${ANS}" != "y" ] || [ "${ANS}" != "yes" ]; then
	echo "ABORTING!"
	exit 2
    fi
    
    ${INSTALLER} install node@10
    ${INSTALLER} unlink node
    ${INSTALLER} link --force --overwrite node@10
fi

# Okay lets install `ghost` now
if [ "$(which ghost 2>/dev/null)" == "" ]; then
    # Install ghost CLI
    echo "INSTALLING: `ghost`"
    npm install ghost-cli@latest -g
fi

#WEBSITE_DIR="www"

cd ${DIR}/..
mkdir -p "${WEBSITE_DIR}"
cd "${WEBSITE_DIR}"

# TODO: check and see if ghost is already installed!
ghost install local
