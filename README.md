# System.Security.AccessControl.Commands

Dieses PowerShell Modul soll die Verwaltung von Berechtigungen auf einem Fileserver erleichtern. Es erweitert das vorhandene Microsoft.PowerShell.Security Module, um die Vergabe, die Anpassung oder Optimierung von FileSystemAccessRules. 

Dabei werden die .Net-Klassen des Namespaces System.Security.AccessControl verwendet.

## Voraussetzungen

Um dieses Module nutzen zu können, ist .Net Standard notwendig. Dies sollte bei Windows Systemen standardmäßig zur Verfügung stehen.

## Installation

Kopieren Sie das Module in eins der PowerShell Module Pfade.

## Verwendung

In diesem Beispiel wird gezeigt und erläutert, wie das Module verwendet werden kann.

```powershell
# Importieren des Moduls
Import-Module System.Security.AccessControl.Commands

# Pfad angegeben
$TargetPath = "C:\Support\test"

# Erstellung einer ACE
$ACE = New-FileSystemAccessRule -IdentityReference "DOMAIN\GROUP" -FileSystemRights FullControl -InheritanceFlags ContainerInherit, ObjectInherit -PropagationFlags None -AccessControlType Allow

# Kontrolliert, ob die ACE bereits existiert
if (-NOT (Test-FileSystemAccessRule -TargetPath $TargetPath -FileSystemAccessRule $ACE))
{
    Add-FileSystemAccessRuleToACL $ACE -TargetPath $TargetPath
}
```

## Hinweis

Das Module verwendet Enumerationen des Namepaces [System.Security.AccessControl], mit denen die Umsetzung vereinfacht wird.