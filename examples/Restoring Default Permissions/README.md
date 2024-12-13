# Restoring Default Permissions

This script resets the permissions of a file or directory to a default configuration by removing all existing rules and applying a predefined set of access rules.

```powershell
# Define the target path
$targetPath = "C:\Projects\Project1"
$backupFile = "C:\Backups\Project1ACL.xml"

# Backup current ACL
Backup-ACL -Path $targetPath -BackupFile $backupFile

# Define default rules
$adminRule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ContainerInherit,ObjectInherit -PropagationFlags None -AccessControlType Allow

$userRule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Users" -FileSystemRights Read -InheritanceFlags ContainerInherit,ObjectInherit -PropagationFlags None -AccessControlType Allow

# Remove all existing rules
Remove-FileSystemAccessRule -TargetPath $targetPath -All

# Add default rules
Add-FileSystemAccessRule -FileSystemAccessRule $adminRule -TargetPath $targetPath
Add-FileSystemAccessRule -FileSystemAccessRule $userRule -TargetPath $targetPath

Write-Output "Default permissions applied to $targetPath."
```

## Explanation

1. **Backup Existing ACL**:  
   The `Backup-ACL` cmdlet saves the current ACL of the target path to an XML file, allowing for future restoration if necessary.

2. **Define Default Rules**:  
   Default access rules are created for administrators (`FullControl`) and regular users (`Read`) using the `New-FileSystemAccessRule` cmdlet.

3. **Clear Existing Rules**:  
   The script retrieves the current ACL, iterates over all existing access rules, and removes them to ensure a clean slate.

4. **Apply Default Rules**:  
   The predefined rules are added to the ACL of the target path using the `Add-FileSystemAccessRule` cmdlet.

5. **Output Result**:  
   A success message confirms that the default permissions have been successfully applied.

## Key Use Cases

- **Reset Permissions**: Quickly restore permissions to a known and controlled state after unauthorized changes.
- **Standardized Setup**: Enforce consistent permission configurations across files and directories.
- **Error Recovery**: Correct misconfigured permissions with a reliable default rule set.

This script is ideal for environments where maintaining a consistent and secure permission baseline is essential.
