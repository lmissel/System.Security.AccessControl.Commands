---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Restore-ACL

## SYNOPSIS

Restores the Access Control List (ACL) of a specified file or directory from a backup file.

## SYNTAX

```powershell
Restore-ACL [-Path] <String> [-BackupFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Restore-ACL` cmdlet restores the ACL of a file or directory to a previous state using a backup file in XML format.
This is particularly useful for recovering or reverting permissions after changes or accidental modifications.

The cmdlet clears all existing Access Control Entries (ACEs) and applies the rules from the provided backup file.

## EXAMPLES

### EXAMPLE 1

```powershell
Restore-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"
```

Description:
Restores the ACL of the directory `C:\MyFolder` from the backup file located at `C:\Backups\MyFolderACL.xml`.

### EXAMPLE 2

```powershell
Restore-ACL -Path "C:\MyFile.txt" -BackupFile "C:\Backups\MyFileACL.xml"
```

Description:
Restores the ACL of the file `C:\MyFile.txt` from the backup file located at `C:\Backups\MyFileACL.xml`.

## PARAMETERS

### -BackupFile

The path to the XML file that contains the backup of the ACL.
This file must be created using the `Backup-ACL` cmdlet to ensure compatibility.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Path

The absolute path to the file or directory whose ACL is to be restored.

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

### Strings

The path to the file or directory whose ACL is being restored.
The path to the backup file containing the ACL.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet relies on the `Get-Acl`, `Set-Acl`, and `Import-Clixml` cmdlets to manipulate ACLs and read backup files.

## RELATED LINKS

[More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
