#!/bin/bash
set -e

function is_branch_exists {
	if ! git branch -a --list | grep -q "$1"
	then
		return 1
	else
		return 0
	fi
}

function is_tag_exists {
	if [ ! $(git tag -l "v${1}") ]
	then
		return 1
	else
		return 0
	fi
}
function is_workspace_clean {
	#if [ -n "$(git status --porcelain)" ]
	if git diff-files --quiet --ignore-submodules --
	then
		return 0
	else
		return 1
	fi
}

function is_workspace_synced {
	if test "$(git rev-parse origin/${CURRENT_BRANCH})" = "$(git rev-parse HEAD)"
	then
		return 0
	else
		return 1
	fi
}

function git_fetch {
	git fetch origin --prune
}

function git_reset {
	git reset --hard && git clean -df
	git pull
}
