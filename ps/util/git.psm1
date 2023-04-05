function is_branch_exists($branch)
{
    if ((git branch -a --list | grep) -ne $branch)
    {
        return 1
    }
    else
    {
        return 0
    }
}

function is_tag_exists($tag)
{
    if (-not$( git tag -l "v${tag}" ))
    {
        return 1
    }

    else
    {
        return 0
    }
}
function is_workspace_clean
{
    #if [ -n "$(git status --porcelain)" ]
    if (git diff-files --quiet --ignore-submodules --)
    {
        return 0
    }

    else
    {
        return 1
    }
}

function is_workspace_synced
{
    if test "$( git rev-parse origin/${CURRENT_BRANCH

} )" = "$( git rev-parse HEAD )"
    then
    return 0
    else
    return 1
    fi
}

function git_fetch
{
    &git fetch origin --prune
}

function git_reset
{
    &git reset --hard && git clean -df
    &git pull
}