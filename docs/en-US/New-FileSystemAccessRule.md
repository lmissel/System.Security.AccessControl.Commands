---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# New-FileSystemAccessRule

## SYNOPSIS

Creates a new file system access rule (ACE) for a user or group.

## SYNTAX

```powershell
New-FileSystemAccessRule -IdentityReference <NTAccount> -FileSystemRights <FileSystemRights[]>
 -InheritanceFlags <InheritanceFlags[]> -PropagationFlags <PropagationFlags[]> -AccessControlType <AccessControlType> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `New-FileSystemAccessRule` cmdlet creates a new `FileSystemAccessRule` object based on the specified parameters.
This rule can then be applied to the Access Control List (ACL) of a file or directory to grant or deny specific permissions.

The cmdlet provides full control over parameters such as inheritance, propagation, access type (allow/deny), and file system rights.

## EXAMPLES

### EXAMPLE 1

```powershell
New-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -InheritanceFlags ContainerInherit -PropagationFlags None -AccessControlType Allow
```

Description:
Creates an access rule that grants `Read` permissions to `DOMAIN\User` and applies it to the current folder and its subfolders.

### EXAMPLE 2

```powershell
New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ObjectInherit -PropagationFlags InheritOnly -AccessControlType Deny
```

Description:
Creates a rule that denies `FullControl` permissions to the `BUILTIN\Administrators` group for child objects only.

## PARAMETERS

### -IdentityReference

The user or group for which the access rule is created.
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

Specifies the file system rights (e.g., `Read`, `Write`, `FullControl`) to be granted or denied.
Multiple rights can be passed as an array.

```yaml
Type: FileSystemRights[]
Parameter Sets: (All)
Aliases:
Accepted values: ListDirectory, ReadData, WriteData, CreateFiles, CreateDirectories, AppendData, ReadExtendedAttributes, WriteExtendedAttributes, Traverse, ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes, WriteAttributes, Write, Delete, ReadPermissions, Read, ReadAndExecute, Modify, ChangePermissions, TakeOwnership, Synchronize, FullControl

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InheritanceFlags

Specifies whether the access rule is inherited by child objects.
Values include `None`, `ContainerInherit`, and `ObjectInherit`.

```yaml
Type: InheritanceFlags[]
Parameter Sets: (All)
Aliases:
Accepted values: None, ContainerInherit, ObjectInherit

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PropagationFlags

Defines how inheritance of the access rule is propagated to child objects.
Values include `None`, `InheritOnly`, and `NoPropagateInherit`.

```yaml
Type: PropagationFlags[]
Parameter Sets: (All)
Aliases:
Accepted values: None, NoPropagateInherit, InheritOnly

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -AccessControlType

Specifies whether the access rule is an `Allow` or `Deny` rule.

```yaml
Type: AccessControlType
Parameter Sets: (All)
Aliases:
Accepted values: Allow, Deny

Required: True
Position: 4
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

Specifies the user or group for which the rule is created.

### System.Security.AccessControl.FileSystemRights[]

Specifies the file system rights to include in the rule.

### System.Security.AccessControl.InheritanceFlags[]

Specifies inheritance behavior for the rule.

### System.Security.AccessControl.PropagationFlags[]

Specifies propagation behavior for the rule.

### System.Security.AccessControl.AccessControlType

Specifies whether the rule is of type `Allow` or `Deny`.

## OUTPUTS

### System.Security.AccessControl.FileSystemAccessRule

Returns the newly created file system access rule.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet returns a `System.Security.AccessControl.FileSystemAccessRule` object that can be added to an ACL.

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
