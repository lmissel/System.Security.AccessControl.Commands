# Cleaning Up Inheritance and Optimizing Permissions

This script disables inheritance for a file, ensures that existing inherited permissions are preserved, and optimizes permissions by removing redundant or unnecessary access rules for a specific user.

```powershell
# Define the target path
$targetPath = "C:\SensitiveData\File.txt"

# Disable inheritance but preserve existing inherited rules
Set-Inheritance -TargetPath $targetPath -isProtected $true -preserveInheritance $true

# Optimize access rules for a specific user
Optimize-FileSystemAccessRules -IdentityReference "DOMAIN\User" -TargetPath $targetPath

Write-Output "Inheritance disabled and permissions optimized for $targetPath."
```

## Explanation

1. **Disable Inheritance**:  
   The `Set-Inheritance` cmdlet is used to turn off inheritance for the file at the specified path. The `preserveInheritance` parameter ensures that any existing inherited rules are retained.

2. **Optimize Access Rules**:  
   The `Optimize-FileSystemAccessRules` cmdlet cleans up redundant or unnecessary access rules for the specified user or group, ensuring a streamlined and efficient ACL.

3. **Output Result**:  
   The script outputs a message indicating that inheritance has been disabled and permissions have been optimized for the target path.

## Key Use Cases

- **Sensitive Data Protection**: Prevent inherited permissions from exposing sensitive files to unintended access.
- **Permission Cleanup**: Remove redundant or conflicting rules to ensure a clear and manageable permission structure.
- **Access Control Maintenance**: Automate routine tasks for keeping ACLs efficient and up to date.

This approach is ideal for administrators managing sensitive files and seeking a balance between access control and simplicity.
