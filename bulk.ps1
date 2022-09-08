Add-Type -Assembly System.Web
#Import a CSV file of users
$CSV = Import-Csv "~\users.csv"
Write-Host “Username : Password” -foregroundcolor red -backgroundcolor yellow
foreach($LINE in $CSV)
{
    $NewUser="$($LINE.USERNAME)"
    $UsersName="$($LINE.NAME)"
    # $NewPass="$($LINE.PASSWORD)" 
    # $SecurePass=ConvertTo-SecureString –AsPlainText -Force -String "$NewPass"
    $pass=[Web.Security.Membership]::GeneratePassword(32,0)
    New-LocalUser -Name $NewUser -Password $pass -Name $UsersName
    #Add created user to the local admin group
    Add-LocalGroupMember -Group "Administrators" -Member $NewUser
    #Print out the username and password
    Write-Host “$NewUser : $pass” -foregroundcolor red -backgroundcolor yellow 
}