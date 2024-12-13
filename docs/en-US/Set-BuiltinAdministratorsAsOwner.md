---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Set-BuiltinAdministratorsAsOwner

## SYNOPSIS

Sets the owner of a specified file or directory to the Built-in Administrators group.

## SYNTAX

```powershell
Set-BuiltinAdministratorsAsOwner [-TargetPath] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Set-BuiltinAdministratorsAsOwner` cmdlet changes the ownership of the specified file or directory to the Built-in Administrators group.
This is particularly useful for recovering access to resources where the current owner has restricted permissions or is inaccessible.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-BuiltinAdministratorsAsOwner -TargetPath "C:\RestrictedFolder"
```

Description:
Sets the owner of the folder `C:\RestrictedFolder` to the Built-in Administrators group.

### EXAMPLE 2

```powershell
Set-BuiltinAdministratorsAsOwner -TargetPath "C:\MyFile.txt"
```

Description:
Changes the ownership of the file `C:\MyFile.txt` to the Built-in Administrators group.

## PARAMETERS

### -TargetPath

The absolute path to the file or directory for which the ownership should be changed.

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

The path to the file or directory whose ownership will be changed.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

## RELATED LINKS

[More information about file system ownership](https://docs.microsoft.com/en-us/windows/win32/secauthz/security-descriptors-and-owner)
