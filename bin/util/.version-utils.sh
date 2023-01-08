#!/bin/bash
set -e

CURRENT_VERSION=$(grep -o '"version": "[^"]*' "${PWD}/composer.json" | grep -o '[^"]*$')
export CURRENT_VERSION

function version_update {
	sed -i "s/\"version\": \"[^\"]*/\"version\": \"${CURRENT_VERSION}/g" "${PWD}/composer.json"
	sed -i "s/\"version\": \"[^\"]*/\"version\": \"${CURRENT_VERSION}/g" "${PWD}/package.json"
}

function version_patch {
	local delimiter=.
	local array=($(echo "${CURRENT_VERSION}" | tr $delimiter '\n'))
	array[2]=$((array[2]+1))
	CURRENT_VERSION=$(local IFS=$delimiter ; echo "${array[*]}")
}

function version_minor {
	local delimiter=.
	local array=($(echo "${CURRENT_VERSION}" | tr $delimiter '\n'))
	CURRENT_VERSION="${array[0]}.$((array[1]+1))"
}

function version_major {
	local delimiter=.
	local array=($(echo "${CURRENT_VERSION}" | tr $delimiter '\n'))
	#array[0]=$((array[0]+1))
	#array[1]="0"
	#array[2]="0"
	CURRENT_VERSION="$((array[0]+1)).0"
	#CURRENT_VERSION=$(local IFS=$delimiter ; echo "${array[*]}")
}

function version_release {
	local delimiter=.
	local array=($(echo "${CURRENT_VERSION}" | tr $delimiter '\n'))
	echo "$((array[0])).$((array[1]))"
}
