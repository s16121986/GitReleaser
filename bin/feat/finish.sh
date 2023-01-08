#!/bin/bash

set -e

# boot
source "${ROOT_PATH}/util/.script-utils.sh"
source "${ROOT_PATH}/util/.branch-utils.sh"

# validates
validate_branch_prefix "feat-"
validate_workspace

gsv-changelog "CHANGELOG.md"

# merge to dev
branch_merge_to "dev"

# delete branch
branch_delete "dev"

debug "Feat branch completed! Switched to ${CURRENT_BRANCH}"
