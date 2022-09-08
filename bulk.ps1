Add-Type -Assembly System.Web
#Import a CSV file of users
$CSV = Import-Csv ".\users.csv"
Write-Host “Username : Password” -foregroundcolor red -backgroundcolor yellow
foreach($LINE in $CSV)
{
    $NewUser="$($LINE.USERNAME)"
    $UsersName="$($LINE.NAME)"
    # $NewPass="$($LINE.PASSWORD)" 
    $pass=[Web.Security.Membership]::GeneratePassword(32,0)
    $SecurePass=ConvertTo-SecureString –AsPlainText -Force -String "$pass"
    New-LocalUser -Name $NewUser -Password $SecurePass -FullName $UsersName
    #Add created user to the local admin group
    Add-LocalGroupMember -Group "Administrators" -Member $NewUser
    #Print out the username and password
    Write-Host “$NewUser : $pass” -foregroundcolor red -backgroundcolor yellow 
}