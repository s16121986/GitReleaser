#!/bin/bash

set -e

# boot
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_PATH}/.script-utils.sh"
source "${SCRIPT_PATH}/.branch-utils.sh"
source "${SCRIPT_PATH}/.version-utils.sh"

# validates
validate_branch_prefix "rc-"
validate_workspace

debug "Current branch: ${CURRENT_BRANCH}"
debug "Release version: ${CURRENT_VERSION}"

if [ $# -eq 1 ] && [ "${1}" = "--prod" ]
then
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
else
	# merge rc-* -> dev
	branch_merge_to "dev"
fi

debug "Branch merged! Current version is ${CURRENT_VERSION}."
