$CURRENT_BRANCH = &git rev-parse --abbrev-ref HEAD

Export-ModuleMember -Variable CURRENT_BRANCH

function branch_create($branch, $from)
{
    #git checkout -b "${branch}" "${from}"
    Set-Variable -Name "CURRENT_BRANCH" -Value $branch -Scope global
    #$CURRENT_BRANCH = $branch
}
Export-ModuleMember -Function branch_create

function branch_checkout($branch)
{
    git checkout "${branch}"
    Set-Variable -Name "CURRENT_BRANCH" -Value $branch -Scope global
    #$CURRENT_BRANCH = branch
}
Export-ModuleMember -Function branch_checkout

function branch_add_tag($tag)
{
    git tag -a "v${tag}"
}
Export-ModuleMember -Function branch_add_tag

function branch_push
{
    git push origin "${CURRENT_BRANCH}"
}
Export-ModuleMember -Function branch_push

function branch_u_push
{
    git push -u origin "${CURRENT_BRANCH}"
}
Export-ModuleMember -Function branch_u_push

function branch_commit($message)
{
    #$v = &git diff-files
    #echo $v
    #echo $message
    if (git diff-files --quiet --ignore-submodules --)
    {
        git commit -am "${message}"
    }
}
Export-ModuleMember -Function branch_commit

function branch_add_and_commit($message)
{
    git add .
    branch_commit "${message}"
}
Export-ModuleMember -Function branch_add_and_commit

function branch_merge_from($from, $message)
{
    git merge --no-ff "${from}" -m "${message}"
    git push origin "${CURRENT_BRANCH}"
}
Export-ModuleMember -Function branch_merge_from

function branch_merge_to($to)
{
    git checkout "${to}"
    git pull --rebase origin "${to}"
    git merge "${CURRENT_BRANCH}"
    git push origin "${to}"
    git checkout "${CURRENT_BRANCH}"
}
Export-ModuleMember -Function branch_merge_to

function branch_merge_tagged_to($to, $v)
{
    git checkout "${to}"
    git pull --rebase origin "${to}"
    git merge "${CURRENT_BRANCH}"
    git tag "v${v}"
    git push origin "${to}"
    git push origin "v${v}"
    git checkout "${CURRENT_BRANCH}"
}
Export-ModuleMember -Function branch_merge_tagged_to

function branch_delete
{

}
Export-ModuleMember -Function branch_delete

function branch_is($a)
{
    if ($a -eq $branch)
    {
        return 1
    }
    else
    {
        return 0
    }
}
Export-ModuleMember -Function branch_is