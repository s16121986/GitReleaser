#!/bin/bash

set -e

ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export ROOT_PATH

# arguments
TYPE=$1
shift

case $TYPE in
"feat" | "fix" | "rc")
  ACTION=$1
  shift
  ARGS="$(printf "${1+ %q}" "$@")"

  if [ "$ACTION" = "start" ] || [ "$ACTION" = "merge" ] || [ "$ACTION" = "finish" ] || [ "$ACTION" = "help" ]; then
    /bin/bash -c "${ROOT_PATH}/${TYPE}/${ACTION}.sh${ARGS}"
  else
    echo "unknown action"
  fi
  ;;

"branch-delete" | "bd")
  ARGS="$(printf "${1+ %q}" "$@")"
  /bin/bash -c "${ROOT_PATH}/branch-delete.sh${ARGS}"
  ;;

*)
  echo "unknown"
  ;;
esac
