#!/bin/bash

set -e

# boot
source "${ROOT_PATH}/util/.script-utils.sh"
source "${ROOT_PATH}/util/.branch-utils.sh"

# boot arguments
if [[ $# -ne 1 ]] || [ -z "${1}" ]; then
  echo 'Usage: create-feat.sh <branch_version>'
  exit 2
fi

# validate nothing to pull or commit and branch not exists
validate_workspace
validate_branch_exists "feat-${1}"

BRANCH_VERSION=$1

# create branch
branch_create "feat-${BRANCH_VERSION}" "dev"

# update packages
#composer update
#npm update
#npx browserslist@latest --update-db

# commit chages
#branch_add_and_commit "chore(release): feat branch setup"
branch_u_push

debug "Branch ${CURRENT_BRANCH} ready!"
