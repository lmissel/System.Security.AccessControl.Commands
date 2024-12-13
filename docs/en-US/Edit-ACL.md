---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Edit-ACL

## SYNOPSIS

Modifies or replaces existing Access Control List (ACL) rules for a specified file or directory.

## SYNTAX

```powershell
Edit-ACL -IdentityReference <NTAccount> -FileSystemRights <FileSystemRights[]> -AccessControlType <AccessControlType> -TargetPath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Edit-ACL` cmdlet allows administrators to update or replace existing access rules in the ACL of a file or directory.
This is useful for modifying user or group permissions without having to completely reconfigure the ACL.
The cmdlet applies the specified access rule to the target, overwriting existing rules for the provided identity.

## EXAMPLES

### EXAMPLE 1

```powershell
Edit-ACL -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -AccessControlType Allow -TargetPath "C:\MyFolder"
```

Description:
Updates the ACL of the folder `C:\MyFolder` by setting an `Allow` rule with `FullControl` rights for the user `DOMAIN\User`.

### EXAMPLE 2

```powershell
Edit-ACL -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read, Write -AccessControlType Deny -TargetPath "C:\MyFile.txt"
```

Description:
Modifies the ACL of the file `C:\MyFile.txt` by adding a `Deny` rule with `Read` and `Write` permissions for the `BUILTIN\Administrators` group.

## PARAMETERS

### -IdentityReference

The user or group whose access rule should be modified.
This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

```yaml
Type: NTAccount
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FileSystemRights

Specifies the file system rights that should be applied.
Multiple rights can be passed as an array.

```yaml
Type: FileSystemRights[]
Parameter Sets: (All)
Aliases:
Accepted values: ListDirectory, ReadData, WriteData, CreateFiles, CreateDirectories, AppendData, ReadExtendedAttributes, WriteExtendedAttributes, Traverse, ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes, WriteAttributes, Write, Delete, ReadPermissions, Read, ReadAndExecute, Modify, ChangePermissions, TakeOwnership, Synchronize, FullControl

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -AccessControlType

Specifies whether the rule to be applied is of type `Allow` or `Deny`.

```yaml
Type: AccessControlType
Parameter Sets: (All)
Aliases:
Accepted values: Allow, Deny

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetPath

The absolute path to the file or directory where the ACL should be updated.

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

Specifies the user or group whose access rule should be modified.

### System.Security.AccessControl.FileSystemRights[]

Specifies the file system rights to be applied.

### System.Security.AccessControl.AccessControlType

Specifies whether the rule is of type `Allow` or `Deny`.

### String

The path to the file or directory where the ACL should be modified.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl`, `Set-Acl`, and `SetAccessRule` methods to modify ACLs.

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
