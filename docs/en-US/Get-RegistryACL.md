---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Get-RegistryACL

## SYNOPSIS

Retrieves the Access Control List (ACL) for a specified Windows Registry key.

## SYNTAX

```powershell
Get-RegistryACL -RegistryPath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Get-RegistryACL` cmdlet retrieves the ACL for a specified Windows Registry key.
This includes permissions and audit settings for the key.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp"
```

Retrieves the ACL for the `HKLM:\SOFTWARE\MyApp` key.

## PARAMETERS

### -RegistryPath

The path to the Windows Registry key whose ACL should be retrieved.

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

### System.Security.AccessControl.RegistrySecurity

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS
