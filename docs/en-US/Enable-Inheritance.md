---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Enable-Inheritance

## SYNOPSIS

Enables permission inheritance for a file, directory, or Registry key.

## SYNTAX

```powershell
Enable-Inheritance -TargetPath <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Enable-Inheritance` cmdlet enables permission inheritance on the target object (file, directory, or Registry key).
This ensures that the target object inherits permissions from its parent.

## EXAMPLES

### EXAMPLE 1

```powershell
Enable-Inheritance -TargetPath "C:\MyFolder"
```

Description:
Enables inheritance on the folder `C:\MyFolder`.

### EXAMPLE 2

```powershell
Enable-Inheritance -TargetPath "HKLM:\Software\MyKey"
```

Description:
Enables inheritance on the Registry key `HKLM:\Software\MyKey`.

## PARAMETERS

### -TargetPath

The path to the target object (file, directory, or Registry key) for which inheritance should be enabled.

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

### String

The path to the target object (file, directory, or Registry key).

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[More information about ACL inheritance](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
