---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Remove-FileSystemAuditRule

## SYNOPSIS

Removes a file system audit rule from the ACL of a specified file or directory.

## SYNTAX

```powershell
Remove-FileSystemAuditRule -AuditRule <FileSystemAuditRule> -TargetPath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Remove-FileSystemAuditRule` cmdlet removes a specified audit rule from the ACL
of a file or directory.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-FileSystemAuditRule -AuditRule $auditRule -TargetPath "C:\MyFolder"
```

Removes the specified audit rule from `C:\MyFolder`.

## PARAMETERS

### -AuditRule

The audit rule object to be removed from the ACL.

```yaml
Type: FileSystemAuditRule
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetPath

The path to the file or directory where the audit rule will be removed.

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
