#!/bin/bash

#####
# This script should only contain constants needed to be referenced across
# multiple scripts
#####

# From - https://stackoverflow.com/a/246128
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
WEBSITE_DIR="${ROOT}/www"
THEME_DIR="${ROOT}/themes"
