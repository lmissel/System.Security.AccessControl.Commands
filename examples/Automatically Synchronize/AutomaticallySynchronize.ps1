# Define source and target paths
$sourcePath = "C:\SourceFolder"
$targetPath = "C:\TargetFolder"

# Backup ACL of the target directory
Backup-ACL -Path $targetPath -BackupFile "C:\Backups\TargetFolderACL.xml"

# Get ACLs for source and target
$sourceAcl = Get-Acl -LiteralPath $sourcePath

# Compare and synchronize access rules
$difference = Compare-FileSystemAccessRules -ReferenceObject $sourcePath -DifferenceObject $targetPath

if ($difference) {
    foreach ($rule in $sourceAcl.Access) {
        Add-FileSystemAccessRule -FileSystemAccessRule $rule -TargetPath $targetPath
    }
    Write-Output "Permissions synchronized between $sourcePath and $targetPath."
} else {
    Write-Output "No differences found in ACLs. No changes were made."
}
