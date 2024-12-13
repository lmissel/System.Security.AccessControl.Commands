---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Compare-FileSystemAccessRule

## SYNOPSIS

Compares the Access Control Lists (ACLs) of two files or directories and returns the differences in access rules.

## SYNTAX

```powershell
Compare-FileSystemAccessRule -ReferenceObject <String> -DifferenceObject <String> [<CommonParameters>]
```

## DESCRIPTION

The `Compare-FileSystemAccessRules` cmdlet compares the Access Control Lists (ACLs) of two specified files or directories.
It identifies differences in the access rules between the source and target, making it easier to synchronize permissions or
detect discrepancies in configurations.
The comparison is performed on the `Access` property of the ACLs.

## EXAMPLES

### EXAMPLE 1

```powershell
Compare-FileSystemAccessRules -ReferenceObject "C:\Folder1" -DifferenceObject "C:\Folder2"
```

Description:
Compares the ACLs of `C:\Folder1` (reference) and `C:\Folder2` (difference) and returns the differences in their access rules.

### EXAMPLE 2

```powershell
Compare-FileSystemAccessRules -ReferenceObject "C:\MyFile1.txt" -DifferenceObject "C:\MyFile2.txt"
```

Description:
Compares the ACLs of the files `C:\MyFile1.txt` and `C:\MyFile2.txt`, highlighting differences in permissions.

## PARAMETERS

### -ReferenceObject

The path to the file or directory whose ACL will be used as the reference for comparison.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DifferenceObject

The path to the file or directory whose ACL will be compared against the reference.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### String

Paths to the files or directories whose ACLs are being compared.

## OUTPUTS

### PSCustomObject

The differences between the ACLs of the reference and difference objects.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl` cmdlet to retrieve ACLs and `Compare-Object` to perform the comparison.

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
