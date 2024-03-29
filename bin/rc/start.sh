#!/bin/bash

set -e

# boot
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_PATH}/.script-utils.sh"
source "${SCRIPT_PATH}/.branch-utils.sh"
source "${SCRIPT_PATH}/.version-utils.sh"

if [[ $# -ne 1 ]]; then
  echo 'Usage: release feat start <patch>'
  exit 2
fi

PATCH=$1

# validate nothing to pull or commit
validate_workspace

debug "Current version: ${CURRENT_VERSION}"

# increment version
if [[ "${PATCH}" = "major" ]]; then
  version_major
elif [[ "${PATCH}" = "minor" ]]; then
  version_minor
else
  echo 'Usage: checkout-rc.sh "major|minor"'
  exit 2
fi

debug "Release version: ${CURRENT_VERSION}"

validate_tag "${CURRENT_VERSION}"
validate_branch_exists "rc-${CURRENT_VERSION}"

# create branch
branch_create "rc-${CURRENT_VERSION}" "dev"

#log prev release

version_update

mkdir -p "$PWD/release/${CURRENT_VERSION}"
gsv-changelog -i "release/${CURRENT_VERSION}/CHANGELOG.md" -s

# commit changes
branch_add_and_commit "chore(release): ${CURRENT_BRANCH} branch setup"
branch_u_push

debug "Branch ${CURRENT_BRANCH} ready!"
