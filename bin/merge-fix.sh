#!/bin/bash

set -e

# boot
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_PATH}/.script-utils.sh"
source "${SCRIPT_PATH}/.branch-utils.sh"
source "${SCRIPT_PATH}/.version-utils.sh"

# validates
validate_branch_prefix "fix-"
validate_tag "${CURRENT_VERSION}"
validate_workspace

gsv-changelog -i "release/${version_release}/CHANGELOG.md" -s
branch_add_and_commit "chore(release): ${CURRENT_BRANCH} changelog update"

# merge to main
branch_merge_tagged_to "main" "${CURRENT_VERSION}"

# merge to dev
branch_merge_to "dev"

# delete merged branch
branch_delete "dev"

debug "Branch ${CURRENT_BRANCH} merged to main!"
