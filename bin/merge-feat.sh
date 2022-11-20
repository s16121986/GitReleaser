#!/bin/bash

set -e

# boot
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_PATH}/.script-utils.sh"
source "${SCRIPT_PATH}/.branch-utils.sh"

# validates
validate_branch_prefix "feat-"
validate_workspace

gsv-changelog "CHANGELOG.md"

# merge to dev
branch_merge_to "dev"

# delete branch
if [ $# -eq 1 ] && [ "${1}" = "--delete" ]
then
	branch_delete "dev"
fi

debug "Branch ${CURRENT_BRANCH} merged to dev!"
