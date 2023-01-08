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

# delete merged branch
gsv-changelog -i "release/${version_release}/CHANGELOG.md" -s
branch_add_and_commit "chore(release): ${CURRENT_BRANCH} changelog update"

# merge to main
branch_merge_tagged_to "main" "${CURRENT_VERSION}"

# merge to dev
branch_merge_to "dev"

branch_delete "dev"

debug "Branch ${CURRENT_BRANCH} completed"
