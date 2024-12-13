---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Add-RegistryAuditRule

## SYNOPSIS

Adds a Registry audit rule to the System Access Control List (SACL) of a specified Registry key.

## SYNTAX

```powershell
Add-RegistryAuditRule -RegistryAuditRule <RegistryAuditRule> -TargetPath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-RegistryAuditRule` cmdlet appends a new audit rule to the SACL of a specified Registry key.
This allows administrators to monitor specific access attempts for users or groups.

## EXAMPLES

### EXAMPLE 1

```powershell
$rule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success

Add-RegistryAuditRule -RegistryAuditRule $rule -TargetPath "HKLM:\Software\TestKey"
```

Description:
Adds an audit rule that monitors successful attempts to access `FullControl` rights by `DOMAIN\User` on the Registry key `HKLM:\Software\TestKey`.

## PARAMETERS

### -RegistryAuditRule

The `RegistryAuditRule` object to add to the SACL of the Registry key.

```yaml
Type: RegistryAuditRule
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetPath

The path to the Registry key to which the audit rule should be added.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

## OUTPUTS

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS
