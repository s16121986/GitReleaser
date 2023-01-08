#!/bin/bash
set -e

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
export CURRENT_BRANCH

function branch_create {
  git checkout -b "${1}" "${2}"
  CURRENT_BRANCH=$1
}

function branch_checkout {
  git checkout "${1}"
  CURRENT_BRANCH=$1
}

function branch_add_tag {
  git tag -a "v${1}"
}

function branch_push {
  git push origin "${CURRENT_BRANCH}"
}

function branch_u_push {
  git push -u origin "${CURRENT_BRANCH}"
}

function branch_commit {
  if git diff-files --quiet --ignore-submodules --; then
    git commit -am "${1}"
  fi
}

function branch_add_and_commit {
  git add .
  branch_commit "${1}"
}

function branch_merge_from {
  git merge --no-ff "${1}" -m "${2}"
  git push origin "${CURRENT_BRANCH}"
}

function branch_merge_to {
  git checkout "${1}"
  git pull --rebase origin "${1}"
  git merge "${CURRENT_BRANCH}"
  git push origin "${1}"
  git checkout "${CURRENT_BRANCH}"
}

function branch_merge_tagged_to {
  git checkout "${1}"
  git pull --rebase origin "${1}"
  git merge "${CURRENT_BRANCH}"
  git tag "v${2}"
  git push origin "${1}"
  git push origin "v${2}"
  git checkout "${CURRENT_BRANCH}"
}

function branch_delete {
  if [[ "${CURRENT_BRANCH}" = "dev" ]] || [[ "${CURRENT_BRANCH}" = "main" ]]; then
    echo "You try to delete main branches, action forbidden!"
    exit 1
  fi

  git checkout "${1}"
  git branch -D "${CURRENT_BRANCH}"
  git push origin --delete "${CURRENT_BRANCH}"
  CURRENT_BRANCH=$1
}

function branch_is {
  if [ "${CURRENT_BRANCH}" = "${1}" ]; then
    return 1
  else
    return 0
  fi
}
