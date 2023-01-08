#!/bin/bash

set -e

# boot
source "${ROOT_PATH}/.script-utils.sh"
source "${ROOT_PATH}/.branch-utils.sh"
source "${ROOT_PATH}/.version-utils.sh"

# validates
validate_branch_prefix "rc-"
validate_workspace

debug "Current branch: ${CURRENT_BRANCH}"
debug "Release version: ${CURRENT_VERSION}"

# merge rc-* -> dev
branch_merge_to "dev"

debug "Branch merged to dev"
