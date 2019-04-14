#!/bin/bash

#####
# This script takes a single string which should correspond to a theme in the
# root directory and copies that theme into the current ghost install
#####

# From - https://stackoverflow.com/a/246128
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

# Source in our constants. We always start our scripts with this :)
source "${ROOT}/bin/constants.sh"

TARGET_DIR="${WEBSITE_DIR}/current/content/themes"
SYMLINK_FILE="${WEBSITE_DIR}/content/themes/$1"

# Check if the passed in string is a valid directory in the theme directory
if [ -d "${THEME_DIR}/$1" ]; then
    # If so copy the given folder into the current themes directory
    cp -r "${THEME_DIR}/$1" "${TARGET_DIR}/."

    # Check if the symlink doesn't exist
    if [ ! -L "${SYMLINK_FILE}" ]; then
	# Then symlink it to general 'themes' directory
	ln -s "${TARGET_DIR}/$1" "${SYMLINK_FILE}"
	# And restart the `ghost` server
	cd "${WEBSITE_DIR}" && ghost restart
    fi
else
    echo "ERROR: Cannot find that theme, are you sure you spelled it right?"
    exit 3
fi

