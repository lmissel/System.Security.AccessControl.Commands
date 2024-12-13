---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Test-FileSystemAccessRule

## SYNOPSIS

Tests whether a specific file system access rule exists for a given user or group on a specified file or directory.

## SYNTAX

```powershell
Test-FileSystemAccessRule [-IdentityReference] <NTAccount> [-FileSystemRights] <FileSystemRights[]>
 [-TargetPath] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Test-FileSystemAccessRule` cmdlet checks if a specific access rule (defined by user/group, rights, and path) exists in the Access Control List (ACL) of a file or directory. It returns a boolean value: `$true` if the rule exists, and `$false` otherwise. This cmdlet is useful for verifying permission configurations in automated scripts or compliance checks.

## EXAMPLES

### EXAMPLE 1

```powershell
Test-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -TargetPath "C:\MyFolder"
```

Description:
Tests if the user `DOMAIN\User` has `FullControl` rights on the folder `C:\MyFolder`.
Returns `$true` or `$false`.

### EXAMPLE 2

```powershell
Test-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read -TargetPath "C:\MyFile.txt"
```

Description:
Verifies whether the `BUILTIN\Administrators` group has `Read` permissions on the file `C:\MyFile.txt`.

## PARAMETERS

### -FileSystemRights

Specifies the file system rights to test for.
Multiple rights can be passed as an array.

```yaml
Type: FileSystemRights[]
Parameter Sets: (All)
Aliases:
Accepted values: ListDirectory, ReadData, WriteData, CreateFiles, CreateDirectories, AppendData, ReadExtendedAttributes, WriteExtendedAttributes, Traverse, ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes, WriteAttributes, Write, Delete, ReadPermissions, Read, ReadAndExecute, Modify, ChangePermissions, TakeOwnership, Synchronize, FullControl

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IdentityReference

The user or group to check for in the ACL.
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

The path to the file or directory where the access rule should be checked.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

Specifies the user or group whose permissions are being tested.

### System.Security.AccessControl.FileSystemRights[]

Specifies the file system rights to verify.

### String

The path to the file or directory to check.

## OUTPUTS

### Boolean

Returns `$true` if the specified access rule exists, otherwise `$false`.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl` cmdlet to retrieve the ACL of the target path and compares it with the provided criteria.

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
