---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version: https://github.com/lmissel/System.Security.AccessControl.Commands
schema: 2.0.0
---

# New-FileSystemAuditRule

## SYNOPSIS

{{ Fill in the Synopsis }}

## SYNTAX

```powershell
New-FileSystemAuditRule [-IdentityReference] <NTAccount> [-FileSystemRights] <FileSystemRights[]>
 [-AuditFlags] <AuditFlags> [-InheritanceFlags] <InheritanceFlags[]> [-PropagationFlags] <PropagationFlags[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

{{ Fill in the Description }}

## EXAMPLES

### Example 1

```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -AuditFlags

{{ Fill AuditFlags Description }}

```yaml
Type: AuditFlags
Parameter Sets: (All)
Aliases:
Accepted values: None, Success, Failure

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileSystemRights

{{ Fill FileSystemRights Description }}

```yaml
Type: FileSystemRights[]
Parameter Sets: (All)
Aliases:
Accepted values: ListDirectory, ReadData, WriteData, CreateFiles, CreateDirectories, AppendData, ReadExtendedAttributes, WriteExtendedAttributes, Traverse, ExecuteFile, DeleteSubdirectoriesAndFiles, ReadAttributes, WriteAttributes, Write, Delete, ReadPermissions, Read, ReadAndExecute, Modify, ChangePermissions, TakeOwnership, Synchronize, FullControl

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityReference

{{ Fill IdentityReference Description }}

```yaml
Type: NTAccount
Parameter Sets: (All)
Aliases:

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritanceFlags

{{ Fill InheritanceFlags Description }}

```yaml
Type: InheritanceFlags[]
Parameter Sets: (All)
Aliases:
Accepted values: None, ContainerInherit, ObjectInherit

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropagationFlags

{{ Fill PropagationFlags Description }}

```yaml
Type: PropagationFlags[]
Parameter Sets: (All)
Aliases:
Accepted values: None, NoPropagateInherit, InheritOnly

Required: True
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Benannt
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
Position: Benannt
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Keine

## OUTPUTS

### System.Security.AccessControl.FileSystemAuditRule

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[https://github.com/lmissel/System.Security.AccessControl.Commands](https://github.com/lmissel/System.Security.AccessControl.Commands)
