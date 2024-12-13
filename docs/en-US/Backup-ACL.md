---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Backup-ACL

## SYNOPSIS

Creates a backup of the Access Control List (ACL) for a specified file or directory.

## SYNTAX

```powershell
Backup-ACL [-Path] <String> [-BackupFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Backup-ACL` cmdlet exports the current Access Control List (ACL) of a file or directory to an XML file.
This backup can later be used with the `Restore-ACL` cmdlet to revert permissions to their previous state.
The cmdlet serializes the ACL rules into a format compatible with PowerShell, ensuring easy recovery and portability.

## EXAMPLES

### EXAMPLE 1

```powershell
Backup-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"
```

Backs up the ACL of the directory `C:\MyFolder` to the file `C:\Backups\MyFolderACL.xml`.

### EXAMPLE 2

```powershell
Backup-ACL -Path "C:\MyFile.txt" -BackupFile "C:\Backups\MyFileACL.xml"
```

Exports the ACL of the file `C:\MyFile.txt` to the XML file `C:\Backups\MyFileACL.xml`.

## PARAMETERS

### -BackupFile

The path to the XML file where the ACL backup will be stored.
If the specified file already exists, it will be overwritten.

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

The absolute path to the file or directory whose ACL should be backed up.

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

### 1. String

The path to the file or directory whose ACL is being backed up.

### 2. String

The path to the file where the backup will be saved.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Author: lmissel\
Date: 09.12.2024\
Module: System.Security.AccessControl.Commands

This cmdlet uses the `Get-Acl` and `Export-Clixml` cmdlets to retrieve and store ACL information.

## RELATED LINKS

### [Restore-ACL](https://github.com/lmissel/System.Security.AccessControl.Commands/docs/en-US/Restore-ACL.md)

Use the `Restore-ACL` cmdlet to restore ACLs from backups created with this cmdlet.

### [More information about file system ACLs](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists)
