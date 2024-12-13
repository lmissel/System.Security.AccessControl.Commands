# System.Security.AccessControl.Commands

## Overview

The `System.Security.AccessControl.Commands` PowerShell module extends and simplifies the management of file system and Windows Registry permissions, audit rules, inheritance, and ownership. It provides advanced functionality for creating, modifying, comparing, auditing, and restoring Access Control Lists (ACLs) for files, directories, and Registry keys. It complements the functionalities of the `Microsoft.PowerShell.Security` PowerShell module.

>[!Important]
>Use this module with caution as changes to ACLs can affect system security and access. Always back up your ACLs before making modifications.

## Features

- **Manage Access Rules (ACE):**
  - Create, add, edit, or remove access rules for specific users or groups.
- **Manage Audit Rules:**
  - Create, add, or remove audit rules for monitoring access events.
- **Inheritance and Ownership:**
  - Enable or disable inheritance for files, directories, and Registry keys.
  - Change ownership to specific users or groups.
- **Backup and Restore:**
  - Back up and restore ACL configurations in XML format.
- **Compare and Optimize:**
  - Compare ACLs between files, directories, or Registry keys.
  - Optimize ACLs by removing redundant or unnecessary rules.

## Minimum Requirements

- **Windows PowerShell:** Version 5.1 or higher
- **Module Dependency:** `Microsoft.PowerShell.Security` (Version 3.0.0.0 or higher)

## Installation

To install and run this module, copy the folder with the name `System.Security.AccessControl.Commands` in one of the appropriate PowerShell paths and use `Import-Module -Name System.Security.AccessControl.Commands`.

The paths where you can install this module are in the `$env:PSModulePath` global variable. For example, a common path to store a module on a system would be `%SystemRoot%/users/<user>/Documents/PowerShell/Modules/<moduleName>`. Be sure to create a directory for this module that uses the same name `System.Security.AccessControl.Commands` as the script module. If you did not save this module in one of these paths, you must specify the location of the module in the Import-Module command. Otherwise, PowerShell would not be able to find the module.

Starting with PowerShell, if you've placed this module in one of the PowerShell module paths, you don't need to explicitly import it. This module is automatically loaded when a user calls a function of the module. For more information about the module path, see [Importing a PowerShell Module](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/importing-a-powershell-module?view=powershell-7.1) and [Modifying the PSModulePath Installation Path](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/modifying-the-psmodulepath-installation-path?view=powershell-7.1).

To remove this module from active service in the current PowerShell session, use `Remove-Module -name System.Security.AccessControl.Commands`.

> [!Note]
> `Remove-Module` removes a module from the current PowerShell session, but doesn't uninstall the module or delete the module's files.

## Usage

This example shows and explains how the module can be used.

### Add a New Access Rule

```powershell
$rule = New-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -InheritanceFlags ContainerInherit -PropagationFlags None -AccessControlType Allow
Add-FileSystemAccessRule -FileSystemAccessRule $rule -TargetPath "C:\MyFolder"
```

### Compare ACLs

```powershell
Compare-FileSystemAccessRules -ReferenceObject "C:\Folder1" -DifferenceObject "C:\Folder2"
```

### Backup and Restore ACLs

```powershell
# Backup ACL
Backup-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"

# Restore ACL
Restore-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"
```

### Create and Add a Registry Access Rule

```powershell
$rule = New-RegistryAccessRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AccessControlType Allow
Add-RegistryAccessRule -RegistryPath "HKLM:\Software\TestKey" -AccessRule $rule
```

### Add an Audit Rule to a Registry Key

```powershell
$auditRule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
Add-RegistryAuditRule -RegistryAuditRule $auditRule -TargetPath "HKLM:\Software\TestKey"
```

## Changelog

|Version|State|Comment|Date|
|---|---|---|---|
|1.0.0.0|done|Initial module|Aug 3, 2019|
|1.1.0.0|done|New structure and division of the module and functions, bug fixes as well as enhancements.|Dec 9, 2024|

## Note

The module uses enumerations and classes of the namepace [System.Security.AccessControl](https://learn.microsoft.com/de-de/dotnet/api/system.security.accesscontrol?view=net-9.0). This namespace provides programming elements that control access to and audit security-related actions on securable objects.
