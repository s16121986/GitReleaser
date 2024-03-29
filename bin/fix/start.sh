#!/bin/bash

set -e

# boot
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_PATH}/util/.script-utils.sh"
source "${SCRIPT_PATH}/util/.branch-utils.sh"
source "${SCRIPT_PATH}/util/.version-utils.sh"

# validate nothing to pull or commit
validate_workspace

debug "Current version: ${CURRENT_VERSION}"

git checkout main
git pull

# increment version
version_patch
debug "Patched version: ${CURRENT_VERSION}"
validate_tag "${CURRENT_VERSION}"
validate_branch_exists "fix-${CURRENT_VERSION}"

# create branch
branch_create "fix-${CURRENT_VERSION}" "main"

# write version to files
version_update

# commit chages
branch_add_and_commit "chore(release): hotfix branch setup"
branch_u_push

debug "Branch ${CURRENT_BRANCH} ready!"
