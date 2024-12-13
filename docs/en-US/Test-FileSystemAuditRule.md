---
external help file: System.Security.AccessControl.Commands-help.xml
Module Name: System.Security.AccessControl.Commands
online version:
schema: 2.0.0
---

# Test-FileSystemAuditRule

## SYNOPSIS

Tests whether a specific audit rule exists for a file or directory.

## SYNTAX

```powershell
Test-FileSystemAuditRule -AuditRule <FileSystemAuditRule> -TargetPath <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Test-FileSystemAuditRule` cmdlet checks if a specified audit rule exists in the ACL
of a file or directory.

## EXAMPLES

### EXAMPLE 1

```powershell
Test-FileSystemAuditRule -AuditRule $auditRule -TargetPath "C:\MyFolder"
```

Returns `$true` if the specified audit rule exists, otherwise `$false`.

## PARAMETERS

### -AuditRule

The audit rule to test for in the ACL.

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

The path to the file or directory to test for the audit rule.

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
