# Declare Variables
$strName = $env:USERNAME
# Checks to see if folder exists
$FolderExists = Test-Path "E:\ImageData\$strName"
# Creates folder if it doesn't exist
If ($FolderExists -eq $false){
	New-Item "E:\ImageData\$strName" -type directory
	$DirPath = "E:\ImageData\$strName"
}
# Assign Permissions
If ($FolderExists -eq $false){
$target = $DirPath
$acl = Get-Acl $target
$inherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
$propagation = [system.security.accesscontrol.PropagationFlags]"None"
$accessrule = new-object system.security.AccessControl.FileSystemAccessRule ("CREATOR OWNER","FullControl",$inherit,$propagation,"Allow")
	 $acl.AddAccessRule($accessrule)
$accessrule = new-object system.security.AccessControl.FileSystemAccessRule ("NT AUTHORITY\SYSTEM","FullControl",$inherit,$propagation,"Allow")
	 $acl.AddAccessRule($accessrule)
$accessrule = new-object system.security.AccessControl.FileSystemAccessRule ("Administrators","FullControl",$inherit,$propagation,"Allow")
     $acl.AddAccessRule($accessrule)
$accessrule = new-object system.security.AccessControl.FileSystemAccessRule ($strName,"FullControl",$inherit,$propagation,"Allow")
     $acl.AddAccessRule($accessrule)
$acl.SetAccessRuleProtection($true,$false)
$acl.SetOwner([System.Security.Principal.NTAccount]$strName)
Set-Acl -AclObject $acl $target
}