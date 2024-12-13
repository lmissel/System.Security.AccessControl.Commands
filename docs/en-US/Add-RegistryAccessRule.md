---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Add-RegistryAccessRule

## SYNOPSIS

Adds an access rule to the ACL of a specified Windows Registry key.

## SYNTAX

```powershell
Add-RegistryAccessRule -RegistryPath <String> -AccessRule <RegistryAccessRule> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-RegistryAccessRule` cmdlet adds a new access rule to the ACL of a Windows Registry key.

## EXAMPLES

```powershell
$rule = New-RegistryAccessRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AccessControlType Allow

Add-RegistryAccessRule -RegistryPath "HKLM:\SOFTWARE\MyApp" -AccessRule $rule
```

Adds a new access rule granting `FullControl` to `DOMAIN\User` for the `HKLM:\SOFTWARE\MyApp` key.

## PARAMETERS

### -AccessRule

The access rule to be added.

```yaml
Type: RegistryAccessRule
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegistryPath

The path to the Windows Registry key.

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
