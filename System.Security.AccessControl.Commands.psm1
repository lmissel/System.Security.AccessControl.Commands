#Requires -Modules @{ ModuleName="Microsoft.PowerShell.Security"; ModuleVersion="3.0.0.0" }

#-------------------------------------
#
# Module: System.Security.AccessControl.Commands
#
# Description: 
# Dieses Module soll die Verwaltung von Berechtigungen auf einem Fileserver erleichtern.
#
#-------------------------------------

#region FileSystemAccessRule (ACE) - ACL

<#
.Synopsis
   Erzeugt eine neue FileSystemAccessRule (ACE).
.DESCRIPTION
   Dieses Cmdlet erzeugt eine neue FileSystemAccessRule, kurz ACE, anhand der uebergebenen Parameter.
.EXAMPLE
   New-FileSystemAccessRule -IdentityReference ".\Administrator" -FileSystemRights Read -InheritanceFlags ... -PropagationFlags ... -AccessControlType ...
#>
function New-FileSystemAccessRule
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([System.Security.AccessControl.FileSystemAccessRule])]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.Principal.NTAccount] $IdentityReference,
        
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.InheritanceFlags[]] $InheritanceFlags,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=3)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.PropagationFlags[]] $PropagationFlags,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AccessControlType] $AccessControlType
    )

    Begin
    {
    }
    Process
    {
        #ACE1 erstellen
        $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
    }
    End
    {    
        #Ausgabe der ACE
        return $FileSystemAccessRule
    }
}

<#
# Hinzufuegen einer FileSystemAccessRule auf einem Objekt
#>
function Add-FileSystemAccessRuleToACL
{
    [CmdletBinding()]
    [Alias()]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemAccessRule] $FileSystemAccessRule,
        
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    Process
    {
        $acl.AddAccessRule($FileSystemAccessRule)
    }
    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

<#
# Editierung einer FileSystemAccessRule
#>
function Edit-ACL
{
    [CmdletBinding()]
    [Alias()]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.Principal.NTAccount] $IdentityReference,
        
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AccessControlType] $AccessControlType,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=5)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    Process
    {
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $AccessControlType)
        $acl.SetAccessRule($AccessRule)
    }
    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

<#
# Entfernung einer FileSystemAccessRule
#>
function Remove-FileSystemAccessRuleFromACL
{
    [CmdletBinding()]
    [Alias()]
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.Principal.NTAccount] $IdentityReference,
                        
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,
        
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=4)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AccessControlType] $AccessControlType,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    Process
    {
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $AccessControlType)
        $acl.RemoveAccessRule($AccessRule)
    }
    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function Compare-FileSystemAccessRules
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Pfad zum ReferenceObject
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [String] $ReferenceObject,

        # Pfad zum DifferenceObject
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=1)]
        [String] $DifferenceObject
    )

    Begin
    {
    }
    Process
    {
        $SourceFolderItems = Get-Acl -Path $Source
        $TargetFolderItems = Get-Acl -Path $Target
        $Result = Compare-Object -ReferenceObject $SourceFolderItems.Access -DifferenceObject $TargetFolderItems.Access 
    }
    End
    {
        return $Result
    }
}

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function Optimize-FileSystemAccessRules
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.Principal.NTAccount] $IdentityReference,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    Process
    {
        $acl.PurgeAccessRules($IdentityReference)   
    }
    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Test-FileSystemAccessRule -IdentityReference DOMAIN\BENUTZERNAME -TargetPath C:\Users -FileSystemRights FullControl

.EXAMPLE
   Test-FileSystemAccessRule -IdentityReference VORDEFINIERT\Administratoren -TargetPath $targetPath -FileSystemRights FullControl

   Ausgabe: True or False
#>
function Test-FileSystemAccessRule
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.Principal.NTAccount] $IdentityReference,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        [bool] $isIncluded = $false
    }
    Process
    {
        $acl = Get-Acl -LiteralPath $TargetPath
        [System.Security.AccessControl.AuthorizationRuleCollection] $ACEs = $acl.GetAccessRules($true, $true, [System.Security.Principal.NTAccount])
        foreach ($ACE in $ACEs)
        {
            if ($ACE.IdentityReference -eq $IdentityReference)
            {
                if ($ACE.FileSystemRights -eq $FileSystemRights)
                {
                    $isIncluded = $true
                }
            }
        }
    }
    End
    {
        return $isIncluded
    }
}

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function Backup-ACL
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Path,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $BackupFile
    )

    Begin
    {
        $acl = Get-ACL -LiteralPath $Path
    }
    Process
    {
        $acl.Access | Export-Clixml -Path $BackupFile
    }
    End
    {
    }
}

<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function Restore-ACL
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Path,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $BackupFile
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $Path
    }
    Process
    {
        # Remove all AccessRules
        $acl.Access | %{$acl.RemoveAccessRule($_)} | Out-Null
        
        # Implement all AccessRules from Backup
        $FileSystemAccessRules = Import-Clixml -Path $BackupFile
        foreach($FileSystemAccessRule in $FileSystemAccessRules)
        {
            $acl.AddAccessRule($FileSystemAccessRule)
        }
    }
    End
    {
        $acl | Set-Acl -LiteralPath $Path
    }
}

#endregion

#-------------------------------------

#region OwnerShip

<#
# lokale Administratoren als Besitzer eintragen
#>
function Set-BuiltinAdministratorsAsOwner
{
    param(
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    
    Process
    {
        #Ownership setzen
        $SID = [System.Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid 
        $Account = New-Object system.security.principal.securityidentifier($SID, $null) 
        $Owner = $Account.Translate([system.security.principal.ntaccount])
        $acl.SetOwner([System.Security.Principal.NTAccount]$Owner)
    }

    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

#endregion

#-------------------------------------

#region Inheritance

<#
.Synopsis
   Aktiverung oder Deakivierung der Vererbung.
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
function Set-Inheritance
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=1)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Bool] $isProtected,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=2)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Bool] $preserveInheritance
    )

    Begin
    {
        $acl = Get-Acl -LiteralPath $TargetPath
    }
    Process
    {
        $Acl.SetAccessRuleProtection($isProtected,$preserveInheritance)
    }
    End
    {
        $acl | Set-Acl -LiteralPath $TargetPath
    }
}

#endregion
