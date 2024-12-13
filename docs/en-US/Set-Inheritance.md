---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Set-Inheritance

## SYNOPSIS

Enables or disables permission inheritance and specifies whether existing inherited rules should be preserved or removed.

## SYNTAX

```powershell
Set-Inheritance [-TargetPath] <String> [-isProtected] <Boolean> [-preserveInheritance] <Boolean> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-Inheritance` cmdlet allows administrators to enable or disable permission inheritance on a file or directory.
Additionally, it allows specifying whether existing inherited rules in the ACL should be preserved or removed.
This is useful for ensuring granular control over security policies and preventing unintended changes to permissions.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-Inheritance -TargetPath "C:\Test" -isProtected $true -preserveInheritance $false
```

Description:
Disables inheritance on the directory `C:\Test` and removes all previously inherited permissions from the ACL.

### EXAMPLE 2

```powershell
Set-Inheritance -TargetPath "C:\Test" -isProtected $false -preserveInheritance $true
```

Description:
Enables inheritance on the directory `C:\Test`.
Existing rules remain unchanged.

## PARAMETERS

### -isProtected

A boolean value indicating whether inheritance should be disabled (True) or enabled (False).

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -preserveInheritance

A boolean value indicating whether existing inherited permissions in the ACL should be preserved (True)
or removed (False) when inheritance is disabled.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetPath

The absolute path to the file or directory where inheritance settings should be changed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

### String

The absolute path to the file or directory.

### Boolean

Values to control inheritance and preservation of existing rules.

## OUTPUTS

### None

This cmdlet does not return any values.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
