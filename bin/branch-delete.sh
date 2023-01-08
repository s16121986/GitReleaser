#!/bin/bash

set -e

# boot
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_PATH}/util/.git-utils.sh"

if [[ "${1}" = "dev" ]] || [[ "${1}" = "main" ]]
then
	debug "You try to delete main branches, action forbidden!"
	exit 1
fi

#update branches list
git_fetch

#delete local
if is_branch_exists "${1}" -eq 1
then
	git branch -D "${1}"
fi

#delete remote
if is_branch_exists "origin/${1}" -eq 1
then
	git push origin --delete "${1}"
fi
