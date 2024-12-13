---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Remove-FileSystemAccessRule

## SYNOPSIS

Removes a specified file system access rule from the Access Control List (ACL) of a given file or directory.

## SYNTAX

```powershell
Remove-FileSystemAccessRule [-IdentityReference] <NTAccount> [-FileSystemRights] <FileSystemRights[]>
 [-AccessControlType] <AccessControlType> [-TargetPath] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-FileSystemAccessRuleFromACL` cmdlet removes a specific access rule (defined by user/group, rights, and control type)
from the ACL of a specified file or directory.
This is useful for managing permissions by cleaning up unnecessary or outdated access rules.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-FileSystemAccessRuleFromACL -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -AccessControlType Deny -TargetPath "C:\MyFolder"
```

Description:
Removes a `Deny` rule with `FullControl` rights for the user `DOMAIN\User` from the ACL of the folder `C:\MyFolder`.

### EXAMPLE 2

```powershell
Remove-FileSystemAccessRuleFromACL -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read -AccessControlType Allow -TargetPath "C:\MyFile.txt"
```

Description:
Removes an `Allow` rule with `Read` permissions for the `BUILTIN\Administrators` group from the ACL of the file `C:\MyFile.txt`.

## PARAMETERS

### -AccessControlType

Specifies whether the rule to be removed is of type `Allow` or `Deny`.

```yaml
Type: AccessControlType
Parameter Sets: (All)
Aliases:
Accepted values: Allow, Deny

Required: True
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FileSystemRights

Specifies the file system rights that define the rule to be removed.
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

The user or group whose access rule should be removed.
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

The absolute path to the file or directory where the access rule should be removed.

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

The user or group whose access rule is being removed.

### System.Security.AccessControl.FileSystemRights[]

Specifies the file system rights that define the rule to be removed.

### System.Security.AccessControl.AccessControlType

Specifies whether the rule is of type `Allow` or `Deny`.

### String

The path to the file or directory where the rule should be removed.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl` and `Set-Acl` cmdlets to manipulate ACLs and remove specific rules.

## RELATED LINKS

More information about file system ACLs: [https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
