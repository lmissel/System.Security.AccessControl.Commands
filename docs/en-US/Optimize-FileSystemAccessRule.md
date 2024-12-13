---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Optimize-FileSystemAccessRule

## SYNOPSIS

Removes redundant or unnecessary file system access rules for a specified user or group on a given file or directory.

## SYNTAX

```powershell
Optimize-FileSystemAccessRule [-IdentityReference] <NTAccount> [-TargetPath] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Optimize-FileSystemAccessRules` cmdlet simplifies the Access Control List (ACL) of a file or directory by removing redundant or conflicting access rules
for a specified user or group.
This can help maintain a clean and efficient permission structure, particularly in scenarios where permissions
have been modified multiple times and may have accumulated unnecessary rules.

## EXAMPLES

### EXAMPLE 1

```powershell
Optimize-FileSystemAccessRules -IdentityReference "DOMAIN\User" -TargetPath "C:\MyFolder"
```

Description:
Optimizes the ACL of the folder `C:\MyFolder` by removing redundant or conflicting access rules for `DOMAIN\User`.

### EXAMPLE 2

```powershell
Optimize-FileSystemAccessRules -IdentityReference "BUILTIN\Administrators" -TargetPath "C:\MyFile.txt"
```

Description:
Simplifies the ACL of the file `C:\MyFile.txt` by purging unnecessary access rules for the `BUILTIN\Administrators` group.

## PARAMETERS

### -IdentityReference

The user or group whose access rules should be optimized.
This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

```yaml
Type: NTAccount
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetPath

The path to the file or directory for which the access rules should be optimized.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Security.Principal.NTAccount

Specifies the user or group whose access rules should be optimized.

### String

The path to the file or directory where access rules should be optimized.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `PurgeAccessRules` method of the ACL to remove all access rules associated with the specified identity.

## RELATED LINKS

More information about file system ACLs: [https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
