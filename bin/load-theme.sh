#!/bin/bash

#####
# This script takes a single string which should correspond to a theme in the
# root directory and copies that theme into the current ghost install
#####

# From - https://stackoverflow.com/a/246128
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

# Source in our constants. We always start our scripts with this :)
source "${ROOT}/bin/constants.sh"

# Check if the passed in string is a valid directory in the theme directory
if [ -d "${THEME_DIR}/$1" ]; then
    # If so copy the given folder into the current themes directory
    TARGET_DIR="${WEBSITE_DIR}/current/content/themes"
    cp -fr "${THEME_DIR}/$1" "${TARGET_DIR}/."
    # Then symlink it to general 'themes' directory
    ln -s "${TARGET_DIR}/$1" "${WEBSITE_DIR}/content/themes/$1" 2>/dev/null
else
    echo "ERROR: Cannot find that theme, are you sure you spelled it right?"
    exit 3
fi

