---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Disable-Inheritance

## SYNOPSIS

Disables permission inheritance for a file, directory, or Registry key and optionally removes inherited rules.

## SYNTAX

```powershell
Disable-Inheritance -TargetPath <String> [-RemoveInheritedRules] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Disable-Inheritance` cmdlet disables permission inheritance on the target object (file, directory, or Registry key).
It provides an option to preserve existing inherited rules or remove them entirely.

## EXAMPLES

### EXAMPLE 1

```powershell
Disable-Inheritance -TargetPath "C:\MyFolder" -RemoveInheritedRules
```

Disables inheritance on the folder `C:\MyFolder` and removes all previously inherited rules.

### EXAMPLE 2

```powershell
Disable-Inheritance -TargetPath "HKLM:\Software\MyKey"
```

Disables inheritance on the Registry key `HKLM:\Software\MyKey` but preserves all inherited rules.

## PARAMETERS

### -RemoveInheritedRules

A switch indicating whether inherited rules should be removed.
If not specified, inherited rules will be preserved.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetPath

The path to the target object (file, directory, or Registry key) for which inheritance should be disabled.

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

### SwitchParameter

Determines whether inherited rules are removed or preserved.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[More information about ACL inheritance](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
