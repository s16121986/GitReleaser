#!/bin/bash

set -e

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# arguments
ACTION=$1
shift
ARGS="$(printf "${1+ %q}" "$@")"
#ARGS="$@"

case $ACTION in
  "create-feat"|"feat")
    /bin/bash -c "${SCRIPT_PATH}/create-feat.sh${ARGS}"
    ;;

  "merge-feat")
    /bin/bash -c "${SCRIPT_PATH}/merge-feat.sh${ARGS}"
    ;;

  "create-fix"|"fix")
    /bin/bash -c "${SCRIPT_PATH}/create-fix.sh${ARGS}"
    ;;

  "merge-fix")
    /bin/bash -c "${SCRIPT_PATH}/merge-fix.sh${ARGS}"
    ;;

  "create-rc"|"rc")
    /bin/bash -c "${SCRIPT_PATH}/create-rc.sh${ARGS}"
    ;;

  "merge-rc")
    /bin/bash -c "${SCRIPT_PATH}/merge-rc.sh${ARGS}"
    ;;

  "merge")
    /bin/bash -c "${SCRIPT_PATH}/merge.sh${ARGS}"
    ;;

  "branch-delete"|"bd")
    /bin/bash -c "${SCRIPT_PATH}/branch-delete.sh${ARGS}"
    ;;

  *)
    echo -n "unknown"
    ;;
esac