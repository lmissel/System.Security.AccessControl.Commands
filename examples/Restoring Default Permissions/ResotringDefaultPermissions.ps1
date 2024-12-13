# Define the target path
$targetPath = "C:\Projects\Project1"

# Backup current ACL
Backup-ACL -Path $targetPath -BackupFile "C:\Backups\Project1ACL.xml"

# Define default rules
$adminRule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ContainerInherit,ObjectInherit -PropagationFlags None -AccessControlType Allow
$userRule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Users" -FileSystemRights Read -InheritanceFlags ContainerInherit,ObjectInherit -PropagationFlags None -AccessControlType Allow

# Remove all existing rules
Remove-FileSystemAccessRule -TargetPath $targetPath -All

# Add default rules
Add-FileSystemAccessRule -FileSystemAccessRule $adminRule -TargetPath $targetPath
Add-FileSystemAccessRule -FileSystemAccessRule $userRule -TargetPath $targetPath

Write-Output "Default permissions applied to $targetPath."