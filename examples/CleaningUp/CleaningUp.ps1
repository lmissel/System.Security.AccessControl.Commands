# Define the target path
$targetPath = "C:\SensitiveData\File.txt"

# Disable inheritance but preserve existing inherited rules
Set-Inheritance -TargetPath $targetPath -isProtected $true -preserveInheritance $true

# Optimize access rules for a specific user
Optimize-FileSystemAccessRules -IdentityReference "DOMAIN\User" -TargetPath $targetPath

Write-Output "Inheritance disabled and permissions optimized for $targetPath."