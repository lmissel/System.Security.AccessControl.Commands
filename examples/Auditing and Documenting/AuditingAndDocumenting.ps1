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
