# Import configuration
$config = Get-Content -Path "C:\Config\PermissionsConfig.json" | ConvertFrom-Json

# Apply rules based on configuration
foreach ($entry in $config) {
    $path = $entry.Path
    $identity = $entry.Identity
    $rights = $entry.Rights
    $type = $entry.Type

    # Create a new access rule
    $rule = New-FileSystemAccessRule -IdentityReference $identity -FileSystemRights $rights -InheritanceFlags ContainerInherit,ObjectInherit -PropagationFlags None -AccessControlType $type

    # Add the rule to the specified path
    Add-FileSystemAccessRule -FileSystemAccessRule $rule -TargetPath $path

    Write-Output "Applied rule for $identity on $path with $rights rights."
}