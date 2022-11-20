
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${SCRIPT_PATH}/.git-utils.sh"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function validate_workspace {
	git_fetch

	if ! is_workspace_synced
	then
		echo "Your branch is out of date with its upstream. Did you forget to pull or push any changes before releasing?"
		exit 1
	fi

	if ! is_workspace_clean
	then

		read -p "Your working directory is dirty. Reset changes? [y]: " flag
		if [ -z "${flag}" ] || [ "${flag}" = "y" ] || [ "${flag}" = "Y" ]
		then
			git_reset;
		else
			echo "Terminated. Commit your changes to continue."
			exit 1
		fi

	fi
}

function validate_branch {
	if [[ ! $CURRENT_BRANCH = $1 ]]
	then
		echo "Branch [$1] required (current: $CURRENT_BRANCH)"
		exit 1
	fi
}

function validate_tag {
	if is_tag_exists "${1}" -eq 1
	then
		echo "Git tag [$1] already exists"
		#exit 1
	fi
}

function validate_branch_prefix {
	if [[ ! $CURRENT_BRANCH = $1* ]]
	then
		echo "Wrong branch, current branch must be ${1}*"
		exit 1
	fi
}

function generate_changelog {
    gsv-changelog -i "release/${1}/CHANGELOG.md" -s
}

function debug {
	echo -e "${YELLOW} * ${1}${NC}"
}