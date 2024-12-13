---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Remove-RegistryAuditRule

## SYNOPSIS

Removes a specific Registry audit rule from the SACL of a specified Registry key.

## SYNTAX

```powershell
Remove-RegistryAuditRule -RegistryAuditRule <RegistryAuditRule> -TargetPath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-RegistryAuditRule` cmdlet removes a specific audit rule from the SACL of a specified Registry key.

## EXAMPLES

### EXAMPLE 1

```powershell
$rule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
```

Remove-RegistryAuditRule -RegistryAuditRule $rule -TargetPath "HKLM:\Software\TestKey"

Description:
Removes an audit rule monitoring successful attempts to access `FullControl` rights by `DOMAIN\User` from the Registry key `HKLM:\Software\TestKey`.

## PARAMETERS

### -RegistryAuditRule

The `RegistryAuditRule` object to remove from the SACL.

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

The path to the Registry key from which the audit rule should be removed.

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
