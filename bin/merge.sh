#!/bin/bash

set -e

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
ARGS="$(printf "${1+ %q}" "$@")"

if [[ $CURRENT_BRANCH = feat-* ]]
then
    /bin/bash -c "${SCRIPT_PATH}/merge-feat.sh${ARGS}"
elif [[ $CURRENT_BRANCH = fix-* ]]
then
    /bin/bash -c "${SCRIPT_PATH}/merge-fix.sh${ARGS}"
elif [[ $CURRENT_BRANCH = rc-* ]]
then
    /bin/bash -c "${SCRIPT_PATH}/merge-rc.sh${ARGS}"
else
	echo -n "unknown"
fi
