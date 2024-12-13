# Automatically Synchronize Permissions Between Two Directories

This script ensures that the permissions of a target directory match those of a source directory. It compares the ACLs of both directories and adds any missing access rules from the source to the target.

```powershell
# Define source and target paths
$sourcePath = "C:\SourceFolder"
$targetPath = "C:\TargetFolder"

# Backup ACL of the target directory
Backup-ACL -Path $targetPath -BackupFile "C:\Backups\TargetFolderACL.xml"

# Get ACLs for source and target
$sourceAcl = Get-Acl -LiteralPath $sourcePath
$targetAcl = Get-Acl -LiteralPath $targetPath

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
```

## Explanation

1. **Backup Existing ACL**:  
   Before making changes, the script backs up the current ACL of the target directory using the `Backup-ACL` cmdlet.

2. **Fetch ACLs**:  
   It retrieves the ACLs for the source and target directories using the `Get-Acl` cmdlet.

3. **Compare ACLs**:  
   The script uses `Compare-FileSystemAccessRules` to identify differences between the source and target permissions.

4. **Apply Missing Rules**:  
   For each missing access rule in the target directory, the script adds the rule from the source directory using `Add-FileSystemAccessRule`.

5. **Output Result**:  
   If differences exist, the script synchronizes the permissions and outputs a success message. If no differences are found, it notifies the user that no changes were necessary.

---

This script is particularly useful in scenarios such as:

- **Permission Synchronization**: Ensuring consistent permissions across directories.

- **Disaster Recovery**: Restoring permissions to a target directory after unintended changes.

- **System Administration**: Automating repetitive tasks related to permission management.
