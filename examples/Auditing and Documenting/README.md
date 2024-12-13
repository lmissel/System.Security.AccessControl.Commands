# Auditing and Documenting Permissions for Compliance

This script audits the permissions of a directory and its subdirectories, collects detailed information about each file's ACL, and exports the results to a CSV file for compliance reporting or documentation.

```powershell
# Define the root path
$rootPath = "C:\SharedFolder"

# Create a list to store results
$results = @()

# Recursively check permissions
Get-ChildItem -Path $rootPath -Recurse | ForEach-Object {
    $itemPath = $_.FullName
    $acl = Get-Acl -LiteralPath $itemPath
    $acl.Access | ForEach-Object {
        $results += [PSCustomObject]@{
            Path        = $itemPath
            Identity    = $_.IdentityReference
            Rights      = $_.FileSystemRights
            Inherited   = $_.IsInherited
            AccessType  = $_.AccessControlType
        }
    }
}

# Export results to a CSV file
$results | Export-Csv -Path "C:\ComplianceReports\PermissionsReport.csv" -NoTypeInformation -Encoding UTF8

Write-Output "Permissions report generated: C:\ComplianceReports\PermissionsReport.csv"
```

---

## Explanation

1. **Iterate Through Files and Folders**:  
   The script uses `Get-ChildItem` with the `-Recurse` parameter to retrieve all files and subdirectories within the specified root directory.

2. **Fetch ACLs**:  
   For each item, the script retrieves the ACL using the `Get-Acl` cmdlet and extracts the access rules.

3. **Store Permissions**:  
   The script creates a custom object for each access rule, containing:
   - The path of the file or directory.
   - The user or group the rule applies to.
   - The file system rights granted or denied.
   - Whether the rule is inherited.
   - The type of access (`Allow` or `Deny`).

4. **Export to CSV**:  
   The collected data is exported to a CSV file using `Export-Csv`, which can be used for compliance checks, audits, or documentation.

5. **Output Result**:  
   The script outputs the location of the generated report for user reference.

---

## Key Use Cases

- **Compliance Auditing**: Generate a detailed report of permissions for regulatory or internal compliance requirements.
- **Documentation**: Maintain an up-to-date record of file system permissions.
- **Security Analysis**: Identify potentially over-permissive or misconfigured access rules.

This script is ideal for IT administrators who need to document or audit permissions for sensitive data or shared resources in a structured and repeatable way.
