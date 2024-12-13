---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Set-RegistryACL

## SYNOPSIS

Sets the Access Control List (ACL) for a specified Windows Registry key.

## SYNTAX

```powershell
Set-RegistryACL -RegistryPath <String> -RegistrySecurity <RegistrySecurity> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-RegistryACL` cmdlet applies a new ACL to a specified Windows Registry key.

## EXAMPLES

### EXAMPLE 1

```powershell
$acl = Get-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp"
```

Set-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp" -RegistrySecurity $acl

Applies the ACL to the `HKLM:\SOFTWARE\MyApp` key.

## PARAMETERS

### -RegistryPath

The path to the Windows Registry key where the ACL should be applied.

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

### -RegistrySecurity

The `RegistrySecurity` object that defines the ACL for the registry key.

```yaml
Type: RegistrySecurity
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
