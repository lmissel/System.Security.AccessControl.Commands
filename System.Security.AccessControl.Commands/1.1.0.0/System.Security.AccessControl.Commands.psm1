#region FileSystemAccessRule (ACE) - ACL

class IdentityReferenceTransformAttribute : System.Management.Automation.ArgumentTransformationAttribute
{
    [object] Transform([System.Management.Automation.EngineIntrinsics]$engineIntrinsics, [object] $inputData)
    {
        # Check whether the input is a character string
        if ($inputData -is [string])
        {
            # Regular expression for a SID
            $sidRegex = "^S-\d-\d+-(\d+-){1,14}\d+$"

            if ($inputData -match $sidRegex)
            {
                # Input is a SID
                try
                {
                    $securityIdentifier = [System.Security.Principal.SecurityIdentifier]::new($inputData)
                    return $securityIdentifier
                }
                catch
                {
                    throw [System.FormatException]::new("The input string is not a valid Security Identifier (SID).")
                }
            }
            else
            {
                # Input may be an NT account
                try
                {
                    $ntAccount = [System.Security.Principal.NTAccount]::new($inputData)
                    return $ntAccount
                }
                catch
                {
                    throw [System.FormatException]::new("The input string is not a valid NTAccount name.")
                }
            }
        }
        elseif ($inputData -is [System.Security.Principal.IdentityReference])
        {
            # Input is already a supported IdentityReference
            return $inputData
        }
        else
        {
            # Input is not supported
            throw [System.FormatException]::new("Unsupported input type. Input must be a string, SecurityIdentifier, or NTAccount.")
        }
    }
}

<#
.SYNOPSIS
    Creates a new file system access rule (ACE) for a user or group.

.DESCRIPTION
    The `New-FileSystemAccessRule` cmdlet creates a new `FileSystemAccessRule` object based on the specified parameters.
    This rule can then be applied to the Access Control List (ACL) of a file or directory to grant or deny specific permissions.

    The cmdlet provides full control over parameters such as inheritance, propagation, access type (allow/deny), and file system rights.

.PARAMETER IdentityReference
    The user or group for which the access rule is created. This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

.PARAMETER FileSystemRights
    Specifies the file system rights (e.g., `Read`, `Write`, `FullControl`) to be granted or denied. Multiple rights can be passed as an array.

.PARAMETER InheritanceFlags
    Specifies whether the access rule is inherited by child objects. Values include `None`, `ContainerInherit`, and `ObjectInherit`.

.PARAMETER PropagationFlags
    Defines how inheritance of the access rule is propagated to child objects. Values include `None`, `InheritOnly`, and `NoPropagateInherit`.

.PARAMETER AccessControlType
    Specifies whether the access rule is an `Allow` or `Deny` rule.

.EXAMPLE
    New-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -AccessControlType Allow

    Description:
    Creates an access rule that grants `Read` permissions to `DOMAIN\User` and applies it to the current folder and its subfolders.

.EXAMPLE
    New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ObjectInherit -PropagationFlags InheritOnly -AccessControlType Deny

    Description:
    Creates a rule that denies `FullControl` permissions to the `BUILTIN\Administrators` group for child objects only.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet returns a `System.Security.AccessControl.FileSystemAccessRule` object that can be added to an ACL.

.INPUTS
    System.Security.Principal.NTAccount
        Specifies the user or group for which the rule is created.
    System.Security.AccessControl.FileSystemRights[]
        Specifies the file system rights to include in the rule.
    System.Security.AccessControl.InheritanceFlags[]
        Specifies inheritance behavior for the rule.
    System.Security.AccessControl.PropagationFlags[]
        Specifies propagation behavior for the rule.
    System.Security.AccessControl.AccessControlType
        Specifies whether the rule is of type `Allow` or `Deny`.

.OUTPUTS
    System.Security.AccessControl.FileSystemAccessRule
        Returns the newly created file system access rule.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function New-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("New-FSRule")]
    [OutputType([System.Security.AccessControl.FileSystemAccessRule])]
    param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Full')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Full')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=4,
                   ParameterSetName='Full')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet([System.Security.AccessControl.AccessControlType]::Allow, [System.Security.AccessControl.AccessControlType]::Deny)]
        [System.Security.AccessControl.AccessControlType] $AccessControlType,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Full')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.InheritanceFlags[]] $InheritanceFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Full')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.PropagationFlags[]] $PropagationFlags
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        # Initializes a new instance of the FileSystemAccessRule class using a reference to a user account, a value that specifies the type
        # of operation associated with the access rule, and a value that specifies whether to allow or deny the operation.
        if ($PSCmdlet.ParameterSetName -eq "Default")
        {
            if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $AccessControlType)
                    return $FileSystemAccessRule
                }
                catch
                {
                    Write-Error -Message "An error occurred while creating a new file system access rule for identity '$IdentityReference': $_"
                }
            }
        }
        
        # Initializes a new instance of the FileSystemAccessRule class using a reference to a user account, a value that specifies the type
        # of operation associated with the access rule, a value that determines how rights are inherited, a value that determines how rights
        # are propagated, and a value that specifies whether to allow or deny the operation.
        if ($PSCmdlet.ParameterSetName -eq "Full")
        {
            if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    $FileSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AccessControlType)
                    return $FileSystemAccessRule
                }
                catch
                {
                    Write-Error -Message "An error occurred while creating a new file system access rule for identity '$IdentityReference': $_"
                }
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Adds a specified file system access rule to the Access Control List (ACL) of a file or directory.

.DESCRIPTION
    The `Add-FileSystemAccessRule` cmdlet appends a new access rule to the ACL of a specified file or directory.
    This allows administrators to grant specific permissions to users or groups without modifying existing rules.
    The rule is defined using a `FileSystemAccessRule` object.

.PARAMETER FileSystemAccessRule
    The `FileSystemAccessRule` object that defines the access rights, identity, and control type to be added to the ACL.

.PARAMETER TargetPath
    The absolute path to the file or directory where the access rule should be added.

.EXAMPLE
    $rule = New-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -InheritanceFlags ContainerInherit -PropagationFlags None -AccessControlType Allow
    Add-FileSystemAccessRule -TargetPath "C:\MyFolder" -FileSystemAccessRule $rule 

    Description:
    Adds a new access rule that grants `Read` permissions to `DOMAIN\User` on the folder `C:\MyFolder`.

.EXAMPLE
    $rule = New-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights FullControl -InheritanceFlags ObjectInherit -PropagationFlags InheritOnly -AccessControlType Allow
    Add-FileSystemAccessRule -TargetPath "C:\MyFolder" -FileSystemAccessRule $rule

    Description:
    Appends a new access rule that grants `FullControl` to the `BUILTIN\Administrators` group on the file `C:\MyFile.txt`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl`, `AddAccessRule`, and `Set-Acl` methods to manipulate ACLs.

.INPUTS
    System.Security.AccessControl.FileSystemAccessRule
        Specifies the access rule to be added.
    String
        The path to the file or directory where the access rule should be applied.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Add-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Add-FileSystemAccessRule", "Add-FSRule", "Add-")]
    param(

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemAccessRule] $FileSystemAccessRule
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                # Get the current access settings.
                $acl = Get-Acl -LiteralPath $TargetPath

                # Add the FileSystemAccessRule to the security settings.
                $acl.AddAccessRule($FileSystemAccessRule)

                # Set the new access settings.
                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error -Message "An error occurred while adding the file system access rule to the ACL for the target path '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Modifies or replaces existing Access Control List (ACL) rules for a specified file or directory.

.DESCRIPTION
    The `Edit-ACL` cmdlet allows administrators to update or replace existing access rules in the ACL of a file or directory.
    This is useful for modifying user or group permissions without having to completely reconfigure the ACL.
    The cmdlet applies the specified access rule to the target, overwriting existing rules for the provided identity.

.PARAMETER IdentityReference
    The user or group whose access rule should be modified. This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

.PARAMETER FileSystemRights
    Specifies the file system rights that should be applied. Multiple rights can be passed as an array.

.PARAMETER AccessControlType
    Specifies whether the rule to be applied is of type `Allow` or `Deny`.

.PARAMETER TargetPath
    The absolute path to the file or directory where the ACL should be updated.

.EXAMPLE
    Edit-ACL -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -AccessControlType Allow -TargetPath "C:\MyFolder"

    Description:
    Updates the ACL of the folder `C:\MyFolder` by setting an `Allow` rule with `FullControl` rights for the user `DOMAIN\User`.

.EXAMPLE
    Edit-ACL -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read, Write -AccessControlType Deny -TargetPath "C:\MyFile.txt"

    Description:
    Modifies the ACL of the file `C:\MyFile.txt` by adding a `Deny` rule with `Read` and `Write` permissions for the `BUILTIN\Administrators` group.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl`, `Set-Acl`, and `SetAccessRule` methods to modify ACLs.

.INPUTS
    System.Security.Principal.NTAccount
        Specifies the user or group whose access rule should be modified.
    System.Security.AccessControl.FileSystemRights[]
        Specifies the file system rights to be applied.
    System.Security.AccessControl.AccessControlType
        Specifies whether the rule is of type `Allow` or `Deny`.
    String
        The path to the file or directory where the ACL should be modified.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Edit-ACL
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Edit-FSACL", "Modify-ACL")]
    param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AccessControlType] $AccessControlType
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath
                $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $AccessControlType)
                $acl.SetAccessRule($AccessRule)
                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error -Message "An error occurred while editing the ACL for identity '$IdentityReference' on target path '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Removes a specified file system access rule from the Access Control List (ACL) of a given file or directory.

.DESCRIPTION
    The `Remove-FileSystemAccessRule` cmdlet removes a specific access rule (defined by user/group, rights, and control type)
    from the ACL of a specified file or directory. This is useful for managing permissions by cleaning up unnecessary or outdated access rules.

.PARAMETER IdentityReference
    The user or group whose access rule should be removed. This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

.PARAMETER FileSystemRights
    Specifies the file system rights that define the rule to be removed. Multiple rights can be passed as an array.

.PARAMETER AccessControlType
    Specifies whether the rule to be removed is of type `Allow` or `Deny`.

.PARAMETER TargetPath
    The absolute path to the file or directory where the access rule should be removed.

.EXAMPLE
    Remove-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -AccessControlType Deny -TargetPath "C:\MyFolder"

    Description:
    Removes a `Deny` rule with `FullControl` rights for the user `DOMAIN\User` from the ACL of the folder `C:\MyFolder`.

.EXAMPLE
    Remove-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read -AccessControlType Allow -TargetPath "C:\MyFile.txt"

    Description:
    Removes an `Allow` rule with `Read` permissions for the `BUILTIN\Administrators` group from the ACL of the file `C:\MyFile.txt`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl` and `Set-Acl` cmdlets to manipulate ACLs and remove specific rules.

.INPUTS
    System.Security.Principal.NTAccount
        The user or group whose access rule is being removed.
    System.Security.AccessControl.FileSystemRights[]
        Specifies the file system rights that define the rule to be removed.
    System.Security.AccessControl.AccessControlType
        Specifies whether the rule is of type `Allow` or `Deny`.
    String
        The path to the file or directory where the rule should be removed.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Remove-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='High')]
    [Alias("Remove-FileSystemAccessRule", "Remove-FSRule", "Del-FSRule")]
    param(

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='All')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AccessControlType] $AccessControlType,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='All')]
        [Switch] $All
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ParameterSetName -eq 'Default')
        {
            # Removes an ACL entry on the specified file for the specified account.
            if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    # Get the current access settings.
                    $acl = Get-Acl -LiteralPath $TargetPath

                    # Remove the FileSystemAccessRule from the security settings.
                    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($IdentityReference, $FileSystemRights, $AccessControlType)
                    $acl.RemoveAccessRule($AccessRule)
                    
                    # Set the new access settings.
                    $acl | Set-Acl -LiteralPath $TargetPath
                }
                catch
                {
                    Write-Error -Message "An error occurred while removing the file system access rule for identity '$IdentityReference' on target path '$TargetPath': $_"
                }
            }
        }

        if ($pscmdlet.ParameterSetName -eq 'All')
        {
            # Removes an ACL entry on the specified file for the specified account.
            if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    # Get the current access settings.
                    $acl = Get-Acl -LiteralPath $targetPath
                    $acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) }
                    $acl | Set-Acl -LiteralPath $targetPath                    
                }
                catch
                {
                    Write-Error -Message "An error occurred while removing the file system access rules on target path '$TargetPath': $_"
                }
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Compares the Access Control Lists (ACLs) of two files or directories and returns the differences in access rules.

.DESCRIPTION
    The `Compare-FileSystemAccessRules` cmdlet compares the Access Control Lists (ACLs) of two specified files or directories.
    It identifies differences in the access rules between the source and target, making it easier to synchronize permissions or
    detect discrepancies in configurations. The comparison is performed on the `Access` property of the ACLs.

.PARAMETER ReferenceObject
    The path to the file or directory whose ACL will be used as the reference for comparison.

.PARAMETER DifferenceObject
    The path to the file or directory whose ACL will be compared against the reference.

.EXAMPLE
    Compare-FileSystemAccessRules -ReferenceObject "C:\Folder1" -DifferenceObject "C:\Folder2"

    Description:
    Compares the ACLs of `C:\Folder1` (reference) and `C:\Folder2` (difference) and returns the differences in their access rules.

.EXAMPLE
    Compare-FileSystemAccessRules -ReferenceObject "C:\MyFile1.txt" -DifferenceObject "C:\MyFile2.txt"

    Description:
    Compares the ACLs of the files `C:\MyFile1.txt` and `C:\MyFile2.txt`, highlighting differences in permissions.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl` cmdlet to retrieve ACLs and `Compare-Object` to perform the comparison.

.INPUTS
    String
        Paths to the files or directories whose ACLs are being compared.

.OUTPUTS
    PSCustomObject
        The differences between the ACLs of the reference and difference objects.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Compare-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$false,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Compare-FSRules", "Compare-ACL")]
    [OutputType([PSCustomObject])]
    Param
    (
        # Path to the reference object
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [String] $ReferenceObject,

        # Path to the difference object
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [String] $DifferenceObject
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        try
        {
            # Retrieve ACLs for the reference and difference objects
            $ReferenceAcl = Get-Acl -Path $ReferenceObject
            $DifferenceAcl = Get-Acl -Path $DifferenceObject

            # Compare Access rules
            $ComparisonResult = Compare-Object -ReferenceObject $ReferenceAcl.Access -DifferenceObject $DifferenceAcl.Access

            # Return the comparison result
            return $ComparisonResult
        }
        catch
        {
            Write-Error -Message "An error occurred while comparing the file system access rules between '$ReferenceObject' and '$DifferenceObject': $_"
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Removes redundant or unnecessary file system access rules for a specified user or group on a given file or directory.

.DESCRIPTION
    The `Optimize-FileSystemAccessRules` cmdlet simplifies the Access Control List (ACL) of a file or directory by removing redundant or conflicting access rules
    for a specified user or group. This can help maintain a clean and efficient permission structure, particularly in scenarios where permissions
    have been modified multiple times and may have accumulated unnecessary rules.

.PARAMETER IdentityReference
    The user or group whose access rules should be optimized. This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

.PARAMETER TargetPath
    The path to the file or directory for which the access rules should be optimized.

.EXAMPLE
    Optimize-FileSystemAccessRules -IdentityReference "DOMAIN\User" -TargetPath "C:\MyFolder"

    Description:
    Optimizes the ACL of the folder `C:\MyFolder` by removing redundant or conflicting access rules for `DOMAIN\User`.

.EXAMPLE
    Optimize-FileSystemAccessRules -IdentityReference "BUILTIN\Administrators" -TargetPath "C:\MyFile.txt"

    Description:
    Simplifies the ACL of the file `C:\MyFile.txt` by purging unnecessary access rules for the `BUILTIN\Administrators` group.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `PurgeAccessRules` method of the ACL to remove all access rules associated with the specified identity.

.INPUTS
    System.Security.Principal.NTAccount
        Specifies the user or group whose access rules should be optimized.
    String
        The path to the file or directory where access rules should be optimized.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Optimize-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Optimize-FSRules", "Clean-ACL")]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath

                $acl.PurgeAccessRules($IdentityReference)

                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error -Message "An error occurred while optimizing the file system access rules for the target path '$TargetPath' and identity '$IdentityReference': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Tests whether a specific file system access rule exists for a given user or group on a specified file or directory.

.DESCRIPTION
    The `Test-FileSystemAccessRule` cmdlet checks if a specific access rule (defined by user/group, rights, and path) exists in the Access Control List (ACL)
    of a file or directory. It returns a boolean value: `$true` if the rule exists, and `$false` otherwise.
    This cmdlet is useful for verifying permission configurations in automated scripts or compliance checks.

.PARAMETER IdentityReference
    The user or group to check for in the ACL. This must be provided in the format of an NTAccount, e.g., "DOMAIN\User" or "BUILTIN\Administrators".

.PARAMETER FileSystemRights
    Specifies the file system rights to test for. Multiple rights can be passed as an array.

.PARAMETER TargetPath
    The path to the file or directory where the access rule should be checked.

.EXAMPLE
    Test-FileSystemAccessRule -IdentityReference "DOMAIN\User" -FileSystemRights FullControl -TargetPath "C:\MyFolder"

    Description:
    Tests if the user `DOMAIN\User` has `FullControl` rights on the folder `C:\MyFolder`. Returns `$true` or `$false`.

.EXAMPLE
    Test-FileSystemAccessRule -IdentityReference "BUILTIN\Administrators" -FileSystemRights Read -TargetPath "C:\MyFile.txt"

    Description:
    Verifies whether the `BUILTIN\Administrators` group has `Read` permissions on the file `C:\MyFile.txt`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl` cmdlet to retrieve the ACL of the target path and compares it with the provided criteria.

.INPUTS
    System.Security.Principal.NTAccount
        Specifies the user or group whose permissions are being tested.
    System.Security.AccessControl.FileSystemRights[]
        Specifies the file system rights to verify.
    String
        The path to the file or directory to check.

.OUTPUTS
    Boolean
        Returns `$true` if the specified access rule exists, otherwise `$false`.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Test-FileSystemAccessRule
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Test-FSRule", "Check-ACL")]
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights        
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                [bool] $isIncluded = $false

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

                return $isIncluded
            }
            catch
            {
                Write-Error -Message "An error occurred while testing the file system access rule for the target path '$TargetPath' and identity '$IdentityReference': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Creates a backup of the Access Control List (ACL) for a specified file or directory.

.DESCRIPTION
    The `Backup-ACL` cmdlet exports the current Access Control List (ACL) of a file or directory to an XML file.
    This backup can later be used with the `Restore-ACL` cmdlet to revert permissions to their previous state.
    The cmdlet serializes the ACL rules into a format compatible with PowerShell, ensuring easy recovery and portability.

.PARAMETER Path
    The absolute path to the file or directory whose ACL should be backed up.

.PARAMETER BackupFile
    The path to the XML file where the ACL backup will be stored.
    If the specified file already exists, it will be overwritten.

.EXAMPLE
    Backup-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"

    Description:
    Backs up the ACL of the directory `C:\MyFolder` to the file `C:\Backups\MyFolderACL.xml`.

.EXAMPLE
    Backup-ACL -Path "C:\MyFile.txt" -BackupFile "C:\Backups\MyFileACL.xml"

    Description:
    Exports the ACL of the file `C:\MyFile.txt` to the XML file `C:\Backups\MyFileACL.xml`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet uses the `Get-Acl` and `Export-Clixml` cmdlets to retrieve and store ACL information.

.INPUTS
    String
        The path to the file or directory whose ACL is being backed up.

    String
        The path to the file where the backup will be saved.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    Restore-ACL
        Use the `Restore-ACL` cmdlet to restore ACLs from backups created with this cmdlet.

    More information about ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Backup-ACL
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Backup-FSACL", "Save-ACL")]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Path,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $BackupFile
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($Path, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-ACL -LiteralPath $Path
                $acl.Access | Export-Clixml -Path $BackupFile
            }
            catch
            {
                Write-Error -Message "An error occurred while backing up the ACL for the target path '$Path' to the file '$BackupFile': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Restores the Access Control List (ACL) of a specified file or directory from a backup file.

.DESCRIPTION
    The `Restore-ACL` cmdlet restores the ACL of a file or directory to a previous state using a backup file in XML format.
    This is particularly useful for recovering or reverting permissions after changes or accidental modifications.

    The cmdlet clears all existing Access Control Entries (ACEs) and applies the rules from the provided backup file.

.PARAMETER Path
    The absolute path to the file or directory whose ACL is to be restored.

.PARAMETER BackupFile
    The path to the XML file that contains the backup of the ACL.
    This file must be created using the `Backup-ACL` cmdlet to ensure compatibility.

.EXAMPLE
    Restore-ACL -Path "C:\MyFolder" -BackupFile "C:\Backups\MyFolderACL.xml"

    Description:
    Restores the ACL of the directory `C:\MyFolder` from the backup file located at `C:\Backups\MyFolderACL.xml`.

.EXAMPLE
    Restore-ACL -Path "C:\MyFile.txt" -BackupFile "C:\Backups\MyFileACL.xml"

    Description:
    Restores the ACL of the file `C:\MyFile.txt` from the backup file located at `C:\Backups\MyFileACL.xml`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

    This cmdlet relies on the `Get-Acl`, `Set-Acl`, and `Import-Clixml` cmdlets to manipulate ACLs and read backup files.

.INPUTS
    String
        The path to the file or directory whose ACL is being restored.

    String
        The path to the backup file containing the ACL.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    Backup-ACL
        Use the `Backup-ACL` cmdlet to create backup files for use with this cmdlet.

    More information about ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Restore-ACL
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='High')]
    [Alias("Restore-FSACL", "Load-ACL")]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $Path,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $BackupFile
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($Path, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $Path

                # Remove all AccessRules
                $acl.Access | ForEach-Object{$acl.RemoveAccessRule($_)} | Out-Null

                # Implement all AccessRules from Backup
                $FileSystemAccessRules = Import-Clixml -Path $BackupFile
                foreach($FileSystemAccessRule in $FileSystemAccessRules)
                {
                    $acl.AddAccessRule($FileSystemAccessRule)
                }

                 $acl | Set-Acl -LiteralPath $Path
            }
            catch
            {
                Write-Error -Message "An error occurred while restoring the ACL for the target path '$Path' from the backup file '$BackupFile': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

#endregion

#-------------------------------------

#region FileSystemAudit

<#
.SYNOPSIS
    Creates a new file system audit rule for a user or group.

.DESCRIPTION
    The `New-FileSystemAuditRule` cmdlet creates a new `FileSystemAuditRule` object, which can then be applied
    to a file or directory to configure auditing settings for a specified user or group.

.PARAMETER IdentityReference
    The user or group for whom the audit rule is created. This must be in NTAccount format, e.g., "DOMAIN\User".

.PARAMETER FileSystemRights
    Specifies the file system rights (e.g., `Read`, `Write`, `FullControl`) to monitor.

.PARAMETER AuditFlags
    Specifies whether to audit successful accesses, failed accesses, or both. Possible values are `Success`, `Failure`, or `Success, Failure`.

.PARAMETER InheritanceFlags
    Specifies inheritance behavior for the audit rule.

.PARAMETER PropagationFlags
    Specifies how inheritance is propagated to child objects.

.EXAMPLE
    New-FileSystemAuditRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -AuditFlags Success -InheritanceFlags ContainerInherit -PropagationFlags None

    Creates an audit rule that monitors successful read accesses for `DOMAIN\User`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands
#>
function New-FileSystemAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("New-FSAuditRule")]
    [OutputType([System.Security.AccessControl.FileSystemAuditRule])]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Full')]
        [ValidateNotNullOrEmpty()]
        [Alias('SID', 'NTAccount')]
        [IdentityReferenceTransform()]
        [System.Security.Principal.IdentityReference] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Full')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemRights[]] $FileSystemRights,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Full')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.AuditFlags] $AuditFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Full')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.InheritanceFlags[]] $InheritanceFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=4,
                   ParameterSetName='Full')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.PropagationFlags[]] $PropagationFlags
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        # Initializes a new instance of the FileSystemAuditRule class using a reference to a user account, a value that specifies the type 
        # of operation associated with the audit rule, and a value that specifies when to perform auditing.
        if ($pscmdlet.ParameterSetName -eq "Default")
        {
            if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    $AuditRule = New-Object System.Security.AccessControl.FileSystemAuditRule($IdentityReference, $FileSystemRights, $AuditFlags)
                    return $AuditRule
                }
                catch
                {
                    Write-Error "An error occurred while creating a file system audit rule: $_"
                }
            }
        }

        # Initializes a new instance of the FileSystemAuditRule class using the name of a reference to a user account, a value that specifies
        # the type of operation associated with the audit rule, a value that determines how rights are inherited, a value that determines how
        # rights are propagated, and a value that specifies when to perform auditing.
        if ($pscmdlet.ParameterSetName -eq "Full")
        {
            if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
            {
                try
                {
                    $AuditRule = New-Object System.Security.AccessControl.FileSystemAuditRule($IdentityReference, $FileSystemRights, $InheritanceFlags, $PropagationFlags, $AuditFlags)
                    return $AuditRule
                }
                catch
                {
                    Write-Error "An error occurred while creating a file system audit rule: $_"
                }
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Adds a file system audit rule to the ACL of a specified file or directory.

.DESCRIPTION
    The `Add-FileSystemAuditRule` cmdlet appends a specified audit rule to the Access Control List (ACL)
    of a file or directory.

.PARAMETER AuditRule
    The audit rule object to be added to the ACL.

.PARAMETER TargetPath
    The path to the file or directory where the audit rule will be applied.

.EXAMPLE
    $auditRule = New-FileSystemAuditRule -IdentityReference "DOMAIN\User" -FileSystemRights Read -AuditFlags Success -InheritanceFlags ContainerInherit -PropagationFlags None
    Add-FileSystemAuditRule -AuditRule $auditRule -TargetPath "C:\MyFolder"

    Adds the specified audit rule to `C:\MyFolder`.
#>
function Add-FileSystemAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Add-FSAuditRule")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemAuditRule] $AuditRule        
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath
                $acl.AddAuditRule($AuditRule)
                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error "An error occurred while adding the audit rule to the ACL: $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Removes a file system audit rule from the ACL of a specified file or directory.

.DESCRIPTION
    The `Remove-FileSystemAuditRule` cmdlet removes a specified audit rule from the ACL
    of a file or directory.

.PARAMETER AuditRule
    The audit rule object to be removed from the ACL.

.PARAMETER TargetPath
    The path to the file or directory where the audit rule will be removed.

.EXAMPLE
    Remove-FileSystemAuditRule -AuditRule $auditRule -TargetPath "C:\MyFolder"

    Removes the specified audit rule from `C:\MyFolder`.
#>
function Remove-FileSystemAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='High')]
    [Alias("Remove-FSAuditRule")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemAuditRule] $AuditRule       
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath
                $acl.RemoveAuditRule($AuditRule)
                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error "An error occurred while removing the audit rule from the ACL: $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Tests whether a specific audit rule exists for a file or directory.

.DESCRIPTION
    The `Test-FileSystemAuditRule` cmdlet checks if a specified audit rule exists in the ACL
    of a file or directory.

.PARAMETER AuditRule
    The audit rule to test for in the ACL.

.PARAMETER TargetPath
    The path to the file or directory to test for the audit rule.

.EXAMPLE
    Test-FileSystemAuditRule -AuditRule $auditRule -TargetPath "C:\MyFolder"

    Returns `$true` if the specified audit rule exists, otherwise `$false`.
#>
function Test-FileSystemAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Test-FSAuditRule")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.FileSystemAuditRule] $AuditRule        
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath
                return $acl.Audit | Where-Object { $_ -eq $AuditRule }
            }
            catch
            {
                Write-Error "An error occurred while testing the audit rule in the ACL: $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

#endregion

#-------------------------------------

#region OwnerShip

<#
.SYNOPSIS
    Sets the owner of a specified file or directory to the Built-in Administrators group.

.DESCRIPTION
    The `Set-BuiltinAdministratorsAsOwner` cmdlet changes the ownership of the specified file or directory to the Built-in Administrators group.
    This is particularly useful for recovering access to resources where the current owner has restricted permissions or is inaccessible.

.PARAMETER TargetPath
    The absolute path to the file or directory for which the ownership should be changed.

.EXAMPLE
    Set-BuiltinAdministratorsAsOwner -TargetPath "C:\RestrictedFolder"

    Description:
    Sets the owner of the folder `C:\RestrictedFolder` to the Built-in Administrators group.

.EXAMPLE
    Set-BuiltinAdministratorsAsOwner -TargetPath "C:\MyFile.txt"

    Description:
    Changes the ownership of the file `C:\MyFile.txt` to the Built-in Administrators group.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    String
        The path to the file or directory whose ownership will be changed.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about file system ownership:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/security-descriptors-and-owner

#>
function Set-BuiltinAdministratorsAsOwner
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Set-AdminAsOwner")]
    param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath

                # Set ownership
                $SID = [System.Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid
                $Account = New-Object system.security.principal.securityidentifier($SID, $null)
                $Owner = $Account.Translate([system.security.principal.ntaccount])
                $acl.SetOwner([System.Security.Principal.NTAccount]$Owner)

                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error "An error occurred while setting the owner to Built-in Administrators for the target path '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

#endregion

#-------------------------------------

#region Inheritance

<#
.SYNOPSIS
    Enables or disables permission inheritance and specifies whether existing inherited rules should be preserved or removed.

.DESCRIPTION
    The `Set-Inheritance` cmdlet allows administrators to enable or disable permission inheritance on a file or directory.
    Additionally, it allows specifying whether existing inherited rules in the ACL should be preserved or removed.
    This is useful for ensuring granular control over security policies and preventing unintended changes to permissions.

.PARAMETER TargetPath
    The absolute path to the file or directory where inheritance settings should be changed.

.PARAMETER isProtected
    A boolean value indicating whether inheritance should be disabled (True) or enabled (False).

.PARAMETER preserveInheritance
    A boolean value indicating whether existing inherited permissions in the ACL should be preserved (True)
    or removed (False) when inheritance is disabled.

.EXAMPLE
    Set-Inheritance -TargetPath "C:\Test" -isProtected $true -preserveInheritance $false

    Description:
    Disables inheritance on the directory `C:\Test` and removes all previously inherited permissions from the ACL.

.EXAMPLE
    Set-Inheritance -TargetPath "C:\Test" -isProtected $false -preserveInheritance $true

    Description:
    Enables inheritance on the directory `C:\Test`. Existing rules remain unchanged.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    String
        The absolute path to the file or directory.

    Boolean
        Values to control inheritance and preservation of existing rules.

.OUTPUTS
    None
        This cmdlet does not return any values.

.LINK
    More information about file system ACLs:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists

#>
function Set-Inheritance
{
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Set-FSInherit", "Control-Inherit")]
    Param
    (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Bool] $isProtected,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [Bool] $preserveInheritance
    )

    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-Acl -LiteralPath $TargetPath
                $acl.SetAccessRuleProtection($isProtected,$preserveInheritance)
                $acl | Set-Acl -LiteralPath $TargetPath
            }
            catch
            {
                Write-Error "An error occurred while changing inheritance settings for the target path '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Disables permission inheritance for a file, directory, or Registry key and optionally removes inherited rules.

.DESCRIPTION
    The `Disable-Inheritance` cmdlet disables permission inheritance on the target object (file, directory, or Registry key).
    It provides an option to preserve existing inherited rules or remove them entirely.

.PARAMETER TargetPath
    The path to the target object (file, directory, or Registry key) for which inheritance should be disabled.

.PARAMETER RemoveInheritedRules
    A switch indicating whether inherited rules should be removed. If not specified, inherited rules will be preserved.

.EXAMPLE
    Disable-Inheritance -TargetPath "C:\MyFolder" -RemoveInheritedRules

    Description:
    Disables inheritance on the folder `C:\MyFolder` and removes all previously inherited rules.

.EXAMPLE
    Disable-Inheritance -TargetPath "HKLM:\Software\MyKey"

    Description:
    Disables inheritance on the Registry key `HKLM:\Software\MyKey` but preserves all inherited rules.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    String
        The path to the target object (file, directory, or Registry key).

    SwitchParameter
        Determines whether inherited rules are removed or preserved.

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about ACL inheritance:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists
#>
function Disable-Inheritance {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Disable-FSInheritance", "Disable-RegInheritance")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,

        [Parameter(Mandatory=$false,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [Switch] $RemoveInheritedRules
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                # Determine if the target is a file/directory or a Registry key
                if ($TargetPath -like "HK*:\*") {
                    # Registry key
                    $key = Get-Item -LiteralPath $TargetPath
                    $acl = $key.GetAccessControl()
                    $acl.SetAccessRuleProtection($true, -not $RemoveInheritedRules)
                    $key.SetAccessControl($acl)
                    Write-Verbose "Inheritance disabled for Registry key '$TargetPath'."
                }
                else
                {
                    # File or directory
                    $acl = Get-Acl -Path $TargetPath
                    $acl.SetAccessRuleProtection($true, -not $RemoveInheritedRules)
                    Set-Acl -Path $TargetPath -AclObject $acl
                    Write-Verbose "Inheritance disabled for file or directory '$TargetPath'."
                }
            }
            catch
            {
                Write-Error "Failed to disable inheritance on '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Enables permission inheritance for a file, directory, or Registry key.

.DESCRIPTION
    The `Enable-Inheritance` cmdlet enables permission inheritance on the target object (file, directory, or Registry key).
    This ensures that the target object inherits permissions from its parent.

.PARAMETER TargetPath
    The path to the target object (file, directory, or Registry key) for which inheritance should be enabled.

.EXAMPLE
    Enable-Inheritance -TargetPath "C:\MyFolder"

    Description:
    Enables inheritance on the folder `C:\MyFolder`.

.EXAMPLE
    Enable-Inheritance -TargetPath "HKLM:\Software\MyKey"

    Description:
    Enables inheritance on the Registry key `HKLM:\Software\MyKey`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    String
        The path to the target object (file, directory, or Registry key).

.OUTPUTS
    None
        This cmdlet does not return any output.

.LINK
    More information about ACL inheritance:
    https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-lists
#>
function Enable-Inheritance {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Enable-FSInheritance", "Enable-RegInheritance")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                # Determine if the target is a Registry key or a file/directory
                if ($TargetPath -like "HK*:\*") {
                    # Registry key
                    $key = Get-Item -LiteralPath $TargetPath
                    $acl = $key.GetAccessControl()
                    $acl.SetAccessRuleProtection($false, $true)  # Enable inheritance, keep existing rules
                    $key.SetAccessControl($acl)
                    Write-Verbose "Inheritance enabled for Registry key '$TargetPath'."
                } else {
                    # File or directory
                    $acl = Get-Acl -Path $TargetPath
                    $acl.SetAccessRuleProtection($false, $true)  # Enable inheritance, keep existing rules
                    Set-Acl -Path $TargetPath -AclObject $acl
                    Write-Verbose "Inheritance enabled for file or directory '$TargetPath'."
                }
            }
            catch
            {
                Write-Error "Failed to enable inheritance on '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

#endregion

#-------------------------------------

#region Registry

<#
.SYNOPSIS
    Retrieves the Access Control List (ACL) for a specified Windows Registry key.

.DESCRIPTION
    The `Get-RegistryACL` cmdlet retrieves the ACL for a specified Windows Registry key.
    This includes permissions and audit settings for the key.

.PARAMETER RegistryPath
    The path to the Windows Registry key whose ACL should be retrieved.

.EXAMPLE
    Get-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp"

    Retrieves the ACL for the `HKLM:\SOFTWARE\MyApp` key.
#>
function Get-RegistryACL {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Get-RegACL")]
    [OutputType([System.Security.AccessControl.RegistrySecurity])]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $RegistryPath
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($RegistryPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $key = Get-Item -Path $RegistryPath
                return $key.GetAccessControl()
            }
            catch
            {
                Write-Error "An error occurred while retrieving the ACL for the registry key '$RegistryPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Sets the Access Control List (ACL) for a specified Windows Registry key.

.DESCRIPTION
    The `Set-RegistryACL` cmdlet applies a new ACL to a specified Windows Registry key.

.PARAMETER RegistryPath
    The path to the Windows Registry key where the ACL should be applied.

.PARAMETER RegistrySecurity
    The `RegistrySecurity` object that defines the ACL for the registry key.

.EXAMPLE
    $acl = Get-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp"
    Set-RegistryACL -RegistryPath "HKLM:\SOFTWARE\MyApp" -RegistrySecurity $acl

    Applies the ACL to the `HKLM:\SOFTWARE\MyApp` key.
#>
function Set-RegistryACL {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Set-RegACL")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $RegistryPath,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.RegistrySecurity] $RegistrySecurity
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($RegistryPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $key = Get-Item -Path $RegistryPath
                $key.SetAccessControl($RegistrySecurity)
            }
            catch
            {
                Write-Error "An error occurred while setting the ACL for the registry key '$RegistryPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Creates a new Registry access rule for a user or group.

.DESCRIPTION
    The `New-RegistryAccessRule` cmdlet creates a `RegistryAccessRule` object that defines permissions for a specified user or group
    on a Windows Registry key. The resulting access rule can be added to or removed from the Access Control List (ACL) of a Registry key.

.PARAMETER IdentityReference
    The user or group for which the access rule is created. This must be provided as a string in the format of an NTAccount, e.g., "DOMAIN\User".

.PARAMETER RegistryRights
    Specifies the rights to be granted or denied. Supported rights include `FullControl`, `ReadKey`, `WriteKey`, etc.

.PARAMETER InheritanceFlags
    Specifies how the access rule is inherited by subkeys. Valid values include `None`, `ContainerInherit`, and `ObjectInherit`.

.PARAMETER PropagationFlags
    Defines how inheritance of the access rule is propagated to subkeys. Valid values include `None`, `InheritOnly`, and `NoPropagateInherit`.

.PARAMETER AccessControlType
    Specifies whether the rule allows or denies access. Valid values are `Allow` or `Deny`.

.EXAMPLE
    New-RegistryAccessRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -InheritanceFlags None -PropagationFlags None -AccessControlType Allow

    Creates an access rule that grants `FullControl` permissions to `DOMAIN\User`.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    System.String
        The user or group for which the rule is created.
    System.Security.AccessControl.RegistryRights
        Specifies the rights to include in the rule.
    System.Security.AccessControl.InheritanceFlags
        Specifies inheritance behavior for the rule.
    System.Security.AccessControl.PropagationFlags
        Specifies propagation behavior for the rule.
    System.Security.AccessControl.AccessControlType
        Specifies whether the rule is of type `Allow` or `Deny`.

.OUTPUTS
    System.Security.AccessControl.RegistryAccessRule
        Returns the newly created Registry access rule.

.LINK
    More information about Windows Registry ACLs:
    https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry-security-and-access-rights
#>
function New-RegistryAccessRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("New-RegAccessRule")]
    [OutputType([System.Security.AccessControl.RegistryAccessRule])]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.RegistryRights] $RegistryRights,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [System.Security.AccessControl.InheritanceFlags] $InheritanceFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Default')]
        [System.Security.AccessControl.PropagationFlags] $PropagationFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=4,
                   ParameterSetName='Default')]
        [ValidateSet("Allow", "Deny")]
        [System.Security.AccessControl.AccessControlType] $AccessControlType
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
        {
            try
            {
                # Create and return the RegistryAccessRule
                $rule = New-Object System.Security.AccessControl.RegistryAccessRule(
                    $IdentityReference,
                    $RegistryRights,
                    $InheritanceFlags,
                    $PropagationFlags,
                    $AccessControlType
                )
                return $rule
            }
            catch
            {
                Write-Error "An error occurred while creating the Registry access rule for identity '$IdentityReference': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Adds an access rule to the ACL of a specified Windows Registry key.

.DESCRIPTION
    The `Add-RegistryAccessRule` cmdlet adds a new access rule to the ACL of a Windows Registry key.

.PARAMETER RegistryPath
    The path to the Windows Registry key.

.PARAMETER AccessRule
    The access rule to be added.

.EXAMPLE
    $rule = New-RegistryAccessRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AccessControlType Allow
    Add-RegistryAccessRule -RegistryPath "HKLM:\SOFTWARE\MyApp" -AccessRule $rule

    Adds a new access rule granting `FullControl` to `DOMAIN\User` for the `HKLM:\SOFTWARE\MyApp` key.
#>
function Add-RegistryAccessRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Add-RegAccess")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $RegistryPath,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.RegistryAccessRule] $AccessRule
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($RegistryPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-RegistryACL -RegistryPath $RegistryPath
                $acl.AddAccessRule($AccessRule)
                Set-RegistryACL -RegistryPath $RegistryPath -RegistrySecurity $acl
            }
            catch
            {
                Write-Error "An error occurred while adding the access rule to the registry key '$RegistryPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Removes an access rule from the ACL of a specified Windows Registry key.

.DESCRIPTION
    The `Remove-RegistryAccessRule` cmdlet removes a specified access rule from the ACL of a Windows Registry key.

.PARAMETER RegistryPath
    The path to the Windows Registry key.

.PARAMETER AccessRule
    The access rule to be removed.

.EXAMPLE
    $rule = New-RegistryAccessRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AccessControlType Allow
    Remove-RegistryAccessRule -RegistryPath "HKLM:\SOFTWARE\MyApp" -AccessRule $rule

    Removes the specified access rule from the `HKLM:\SOFTWARE\MyApp` key.
#>
function Remove-RegistryAccessRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='High')]
    [Alias("Remove-RegAccess")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $RegistryPath,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.RegistryAccessRule] $AccessRule
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($RegistryPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $acl = Get-RegistryACL -RegistryPath $RegistryPath
                $acl.RemoveAccessRule($AccessRule)
                Set-RegistryACL -RegistryPath $RegistryPath -RegistrySecurity $acl
            }
            catch
            {
                Write-Error "An error occurred while removing the access rule from the registry key '$RegistryPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Creates a new Registry audit rule for a user or group.

.DESCRIPTION
    The `New-RegistryAuditRule` cmdlet creates a `RegistryAuditRule` object that defines audit settings for a specified user or group
    on a Windows Registry key. The resulting audit rule can be added to the System Access Control List (SACL) of a Registry key.

.PARAMETER IdentityReference
    The user or group for which the audit rule is created. This must be provided as a string in the format of an NTAccount, e.g., "DOMAIN\User".

.PARAMETER RegistryRights
    Specifies the rights to be audited. Supported rights include `FullControl`, `ReadKey`, `WriteKey`, etc.

.PARAMETER InheritanceFlags
    Specifies how the audit rule is inherited by subkeys. Valid values include `None`, `ContainerInherit`, and `ObjectInherit`.

.PARAMETER PropagationFlags
    Defines how inheritance of the audit rule is propagated to subkeys. Valid values include `None`, `InheritOnly`, and `NoPropagateInherit`.

.PARAMETER AuditFlags
    Specifies the type of access to audit. Valid values include `Success`, `Failure`, or both.

.EXAMPLE
    New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success

    Creates an audit rule that monitors successful attempts to access `FullControl` rights by `DOMAIN\User`.

.EXAMPLE
    New-RegistryAuditRule -IdentityReference "BUILTIN\Administrators" -RegistryRights ReadKey -AuditFlags Failure

    Creates an audit rule that monitors failed attempts to read the Registry key by the `BUILTIN\Administrators` group.

.NOTES
    Author: lmissel
    Date: 09.12.2024
    Module: System.Security.AccessControl.Commands

.INPUTS
    System.String
        The user or group for which the rule is created.
    System.Security.AccessControl.RegistryRights
        Specifies the rights to include in the rule.
    System.Security.AccessControl.InheritanceFlags
        Specifies inheritance behavior for the rule.
    System.Security.AccessControl.PropagationFlags
        Specifies propagation behavior for the rule.
    System.Security.AccessControl.AuditFlags
        Specifies whether to audit successful or failed access attempts.

.OUTPUTS
    System.Security.AccessControl.RegistryAuditRule
        Returns the newly created Registry audit rule.

.LINK
    More information about Windows Registry ACLs:
    https://docs.microsoft.com/en-us/windows/win32/sysinfo/registry-security-and-access-rights
#>
function New-RegistryAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("New-RegAuditRule")]
    [OutputType([System.Security.AccessControl.RegistryAuditRule])]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $IdentityReference,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [System.Security.AccessControl.RegistryRights] $RegistryRights,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=2,
                   ParameterSetName='Default')]
        [System.Security.AccessControl.InheritanceFlags] $InheritanceFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=3,
                   ParameterSetName='Default')]
        [System.Security.AccessControl.PropagationFlags] $PropagationFlags,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=4,
                   ParameterSetName='Default')]
        [ValidateSet("Success", "Failure", "Success,Failure")]
        [System.Security.AccessControl.AuditFlags] $AuditFlags
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($IdentityReference, $MyInvocation.MyCommand.Name))
        {
            try
            {
                # Create and return the RegistryAuditRule
                $rule = New-Object System.Security.AccessControl.RegistryAuditRule(
                    $IdentityReference,
                    $RegistryRights,
                    $InheritanceFlags,
                    $PropagationFlags,
                    $AuditFlags
                )
                return $rule
            }
            catch
            {
                Write-Error "An error occurred while creating the Registry audit rule for identity '$IdentityReference': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Adds a Registry audit rule to the System Access Control List (SACL) of a specified Registry key.

.DESCRIPTION
    The `Add-RegistryAuditRule` cmdlet appends a new audit rule to the SACL of a specified Registry key.
    This allows administrators to monitor specific access attempts for users or groups.

.PARAMETER RegistryAuditRule
    The `RegistryAuditRule` object to add to the SACL of the Registry key.

.PARAMETER TargetPath
    The path to the Registry key to which the audit rule should be added.

.EXAMPLE
    $rule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
    Add-RegistryAuditRule -RegistryAuditRule $rule -TargetPath "HKLM:\Software\TestKey"

    Description:
    Adds an audit rule that monitors successful attempts to access `FullControl` rights by `DOMAIN\User` on the Registry key `HKLM:\Software\TestKey`.
#>
function Add-RegistryAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Add-RegAuditRule")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath, 
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [System.Security.AccessControl.RegistryAuditRule] $RegistryAuditRule        
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $key = Get-Item -LiteralPath $TargetPath
                $acl = $key.GetAccessControl([System.Security.AccessControl.AccessControlSections]::Audit)
                $acl.AddAuditRule($RegistryAuditRule)
                $key.SetAccessControl($acl)
                Write-Verbose "Audit rule added successfully."
            }
            catch
            {
                Write-Error "Failed to add audit rule to '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Removes a specific Registry audit rule from the SACL of a specified Registry key.

.DESCRIPTION
    The `Remove-RegistryAuditRule` cmdlet removes a specific audit rule from the SACL of a specified Registry key.

.PARAMETER RegistryAuditRule
    The `RegistryAuditRule` object to remove from the SACL.

.PARAMETER TargetPath
    The path to the Registry key from which the audit rule should be removed.

.EXAMPLE
    $rule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
    Remove-RegistryAuditRule -RegistryAuditRule $rule -TargetPath "HKLM:\Software\TestKey"

    Description:
    Removes an audit rule monitoring successful attempts to access `FullControl` rights by `DOMAIN\User` from the Registry key `HKLM:\Software\TestKey`.
#>
function Remove-RegistryAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='High')]
    [Alias("Remove-RegAuditRule")]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [System.Security.AccessControl.RegistryAuditRule] $RegistryAuditRule        
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $key = Get-Item -LiteralPath $TargetPath
                $acl = $key.GetAccessControl([System.Security.AccessControl.AccessControlSections]::Audit)
                $acl.RemoveAuditRule($RegistryAuditRule)
                $key.SetAccessControl($acl)
                Write-Verbose "Audit rule removed successfully."
            }
            catch
            {
                Write-Error "Failed to remove audit rule from '$TargetPath': $_"
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

<#
.SYNOPSIS
    Tests if a specific Registry audit rule exists in the SACL of a specified Registry key.

.DESCRIPTION
    The `Test-RegistryAuditRule` cmdlet checks whether a specific audit rule exists in the SACL of a specified Registry key.

.PARAMETER RegistryAuditRule
    The `RegistryAuditRule` object to test for in the SACL.

.PARAMETER TargetPath
    The path to the Registry key to check.

.EXAMPLE
    $rule = New-RegistryAuditRule -IdentityReference "DOMAIN\User" -RegistryRights FullControl -AuditFlags Success
    Test-RegistryAuditRule -RegistryAuditRule $rule -TargetPath "HKLM:\Software\TestKey"

    Description:
    Tests whether an audit rule monitoring successful attempts to access `FullControl` rights by `DOMAIN\User` exists for the Registry key `HKLM:\Software\TestKey`.
#>
function Test-RegistryAuditRule {
    [CmdletBinding(DefaultParameterSetName='Default',
                    SupportsShouldProcess=$true,
                    PositionalBinding=$true,
                    HelpUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands',
                    ConfirmImpact='Medium')]
    [Alias("Test-RegAuditRule")]
    [OutputType([bool])]
    param (
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=0,
                   ParameterSetName='Default')]
        [ValidateNotNullOrEmpty()]
        [String] $TargetPath,
        
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false,
                   Position=1,
                   ParameterSetName='Default')]
        [ValidateNotNull()]
        [System.Security.AccessControl.RegistryAuditRule] $RegistryAuditRule        
    )
    Begin
    {
        Write-Verbose -Message ('[{0}] Function started' -f $MyInvocation.MyCommand.Name)
        Write-Verbose -Message ('[{0}] ParameterSetName: {1}' -f $MyInvocation.MyCommand.Name, $PsCmdlet.ParameterSetName)
        Write-Verbose -Message ('[{0}] PSBoundParameters: {1}' -f $MyInvocation.MyCommand.Name, ($PSBoundParameters | Out-String))
    }
    Process
    {
        if ($pscmdlet.ShouldProcess($TargetPath, $MyInvocation.MyCommand.Name))
        {
            try
            {
                $key = Get-Item -LiteralPath $TargetPath
                $acl = $key.GetAccessControl([System.Security.AccessControl.AccessControlSections]::Audit)
                $existingRules = $acl.GetAuditRules($true, $true, [System.Security.Principal.NTAccount])

                foreach ($rule in $existingRules)
                {
                    if ($rule.IdentityReference -eq $RegistryAuditRule.IdentityReference -and
                        $rule.RegistryRights -eq $RegistryAuditRule.RegistryRights -and
                        $rule.AuditFlags -eq $RegistryAuditRule.AuditFlags) {
                        return $true
                    }
                }

                return $false
            }
            catch
            {
                Write-Error "Failed to test audit rule on '$TargetPath': $_"
                return $false
            }
        }
    }
    End
    {
        Write-Verbose -Message ('[{0}] Function ended' -f $MyInvocation.MyCommand.Name)
    }
}

#endregion