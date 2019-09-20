


$Guess="y"

Do{

$DomainController = ""

$SourceUser = Read-Host "Enter username to edit: "
$CopyUser = Read-Host "Enter username to copy: "
$CopyUserObject = Get-ADUser $CopyUser -Properties Description, Office, telephoneNumber, StreetAddress, City, State, PostalCode, Title, Department, Company, DistinguishedName -Server $DomainController
$SourceOU = Get-ADUser $SourceUser
$TargetOU = ($CopyUserObject.DistinguishedName -split ",",2)[1]
Set-ADUser -Identity $SourceUser -Office $CopyUserObject.Office `
          -StreetAddress $CopyUserObject.StreetAddress -City $CopyUserObject.City -State $CopyUserObject.State -PostalCode $CopyUserObject.PostalCode `
          -Server $DomainController -Verbose

Get-ADUser -Identity $CopyUserObject -Properties memberof | Select-Object -ExpandProperty memberof | Add-ADGroupMember -Members $SourceUser -Server $DomainController -Verbose #Copy group memberships
#$Guess=read-host "Another account ? (y/n):" #prompt user to continue
Move-ADObject -Identity $SourceOU -TargetPath $TargetOU -Server $DomainController -Verbose
} #end of do

While ($Guess -ne "n") 
