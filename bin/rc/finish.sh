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

#gsv-changelog -i "release/${CURRENT_VERSION}/CHANGELOG.md" -s
#branch_add_and_commit "chore(release): ${CURRENT_BRANCH} changelog update"

# merge rc-* -> prod
branch_merge_tagged_to "main" "${CURRENT_VERSION}"

# delete rc branch
branch_delete "dev"

# merge main -> prod
git pull --rebase origin dev
git merge main
git push origin dev

debug "Branch completed! Current version is ${CURRENT_VERSION}."
