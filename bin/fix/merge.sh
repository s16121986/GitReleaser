#!/bin/bash

set -e

# boot
source "${ROOT_PATH}/util/.script-utils.sh"
source "${ROOT_PATH}/util/.branch-utils.sh"
source "${ROOT_PATH}/util/.version-utils.sh"

# validates
validate_branch_prefix "fix-"
validate_tag "${CURRENT_VERSION}"
validate_workspace

# merge to feat & rc branches
#for branch in $(git for-each-ref --format='%(refname)' refs/heads/); do
#	echo "$branch"
#git log --oneline "$branch" ^origin/master
#done

# merge to main
branch_merge_to "main"

# merge to dev
branch_merge_to "dev"

debug "Fixes ${CURRENT_BRANCH} merged"
