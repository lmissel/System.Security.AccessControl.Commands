---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# New-RegistryAuditRule

## SYNOPSIS

Creates a new Registry audit rule for a user or group.

## SYNTAX

```powershell
New-RegistryAuditRule [-IdentityReference] <String> [-RegistryRights] <RegistryRights>
 [[-InheritanceFlags] <InheritanceFlags>] [[-PropagationFlags] <PropagationFlags>] [-AuditFlags] <AuditFlags>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `New-RegistryAuditRule` cmdlet creates a `RegistryAuditRule` object that defines audit settings for a specified user or group
on a Windows Registry key.
The resulting audit rule can be added to the System Access Control List (SACL) of a Registry key.

## EXAMPLES

### EXAMPLE 1

```powershell
New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
```

Creates an audit rule that monitors successful attempts to access `FullControl` rights by `DOMAIN\User`.

### EXAMPLE 2

```powershell
New-RegistryAuditRule -IdentityReference "BUILTIN\Administrators" -RegistryRights ReadKey -AuditFlags Failure
```

Creates an audit rule that monitors failed attempts to read the Registry key by the `BUILTIN\Administrators` group.

## PARAMETERS

### -AuditFlags

Specifies the type of access to audit.
Valid values include `Success`, `Failure`, or both.

```yaml
Type: AuditFlags
Parameter Sets: (All)
Aliases:
Accepted values: None, Success, Failure

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IdentityReference

The user or group for which the audit rule is created.
This must be provided as a string in the format of an NTAccount, e.g., "DOMAIN\User".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InheritanceFlags

Specifies how the audit rule is inherited by subkeys.
Valid values include `None`, `ContainerInherit`, and `ObjectInherit`.

```yaml
Type: InheritanceFlags
Parameter Sets: (All)
Aliases:
Accepted values: None, ContainerInherit, ObjectInherit

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropagationFlags

Defines how inheritance of the audit rule is propagated to subkeys.
Valid values include `None`, `InheritOnly`, and `NoPropagateInherit`.

```yaml
Type: PropagationFlags
Parameter Sets: (All)
Aliases:
Accepted values: None, NoPropagateInherit, InheritOnly

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegistryRights

Specifies the rights to be audited.
Supported rights include `FullControl`, `ReadKey`, `WriteKey`, etc.

```yaml
Type: RegistryRights
Parameter Sets: (All)
Aliases:
Accepted values: QueryValues, SetValue, CreateSubKey, EnumerateSubKeys, Notify, CreateLink, Delete, ReadPermissions, WriteKey, ExecuteKey, ReadKey, ChangePermissions, TakeOwnership, FullControl

Required: True
Position: 2
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

### System.String

The user or group for which the rule is created.

### System.Security.AccessControl.RegistryRights

Specifies the rights to include in the rule.

### System.Security.AccessControl.InheritanceFlags

Specifies inheritance behavior for the rule.

### System.Security.AccessControl.PropagationFlags

Specifies propagation behavior for the rule.

### System.Security.AccessControl.AuditFlags

Specifies whether to audit successful or failed access attempts.

## OUTPUTS

### System.Security.AccessControl.RegistryAuditRule

Returns the newly created Registry audit rule.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[More information about Windows Registry ACLs](https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry-security-and-access-rights)
