---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Add-FileSystemAccessRule

## SYNOPSIS

Adds a specified file system access rule to the Access Control List (ACL) of a file or directory.

## SYNTAX

```powershell
Add-FileSystemAccessRule -FileSystemAccessRule <FileSystemAccessRule> -TargetPath <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Add-FileSystemAccessRuleToACL` cmdlet appends a new access rule to the ACL of a specified file or directory.
This allows administrators to grant specific permissions to users or groups without modifying existing rules.
The rule is defined using a `FileSystemAccessRule` object.

## EXAMPLES

### EXAMPLE 1

```powershell
$rule = New-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -InheritanceFlags ContainerInherit -PropagationFlags None -AccessControlType Allow

Add-FileSystemAccessRuleToACL -FileSystemAccessRule $rule -TargetPath "C:\MyFolder"
```

Adds a new access rule that grants `Read` permissions to `DOMAIN\User` on the folder `C:\MyFolder`.

### EXAMPLE 2

```powershell
$rule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ObjectInherit -PropagationFlags InheritOnly -AccessControlType Allow

Add-FileSystemAccessRuleToACL -FileSystemAccessRule $rule -TargetPath "C:\MyFile.txt"
```

Appends a new access rule that grants `FullControl` to the `BUILTIN\Administrators` group on the file `C:\MyFile.txt`.

## PARAMETERS

### -FileSystemAccessRule

The `FileSystemAccessRule` object that defines the access rights, identity, and control type to be added to the ACL.

```yaml
Type: FileSystemAccessRule
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -TargetPath

The absolute path to the file or directory where the access rule should be added.

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

### System.Security.AccessControl.FileSystemAccessRule

Specifies the access rule to be added.

### String

The path to the file or directory where the access rule should be applied.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl`, `AddAccessRule`, and `Set-Acl` methods to manipulate ACLs.

## RELATED LINKS

[More information about file system ACLs:](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
