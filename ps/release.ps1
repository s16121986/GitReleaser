#echo $PSCommandPath
#echo $pwd

$TYPE = $args[0]
Write-Host "d: $TYPE"

#Remove-Module -force branch
Import-Module .\util\branch.psm1 -force

if ($TYPE -eq "feat")
{
    $ACTION = $ARGS[1]
    Import-Module .\$TYPE\$ACTION.psm1 -force
    #run $args
}
else
{

}

#Using module .\util\git.psm1 -force

#$git = New-Object -TypeName Git
#$git = [Git]::new()
branch_add_and_commit test
#echo "dsds"
echo $CURRENT_BRANCH
branch_create rc
echo $CURRENT_BRANCH

if ((branch_is main) -eq 1)
{
    echo "ffff"
}
#echo "12"