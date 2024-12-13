@{

    # Die diesem Manifest zugeordnete Skript- oder Binaermoduldatei.
    RootModule = 'System.Security.AccessControl.Commands.psm1'
    
    # Die Versionsnummer dieses Moduls
    ModuleVersion = '1.1.0.0'
    
    # Unterstuetzte PSEditions
    # CompatiblePSEditions = @()
    
    # ID zur eindeutigen Kennzeichnung dieses Moduls
    GUID = 'a79daa93-d130-4bb3-b0db-2bc29182fc05'
    
    # Autor dieses Moduls
    Author = 'lmisssel'
    
    # Unternehmen oder Hersteller dieses Moduls
    CompanyName = ''
    
    # Urheberrechtserklaerung fuer dieses Modul
    #Copyright = ''
    
    # Beschreibung der von diesem Modul bereitgestellten Funktionen
    Description = 'Cmdlets for managing ACLs, access rules, audit rules, and inheritance for file systems and the Windows Registry.'
    
    # Die fuer dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
    # PowerShellVersion = ''
    
    # Der Name des fuer dieses Modul erforderlichen Windows PowerShell-Hosts
    # PowerShellHostName = ''
    
    # Die fuer dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
    # PowerShellHostVersion = ''
    
    # Die fuer dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur fuer die PowerShell Desktop-Edition gueltig.
    # DotNetFrameworkVersion = ''
    
    # Die fuer dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur fuer die PowerShell Desktop-Edition gueltig.
    # CLRVersion = ''
    
    # Die fuer dieses Modul erforderliche Prozesssorarchitektur ("Keine", "X86", "Amd64").
    # ProcesssorArchitecture = ''
    
    # Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden muesssen
    RequiredModules = @('Microsoft.PowerShell.Security')
    
    # Die Asssemblys, die vor dem Importieren dieses Moduls geladen werden muesssen
    # RequiredAsssemblies = @()
    
    # Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgefuehrt werden.
    # ScriptsToProcesss = @()
    
    # Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # TypesToProcesss = @()
    
    # Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
    # FormatsToProcesss = @()
    
    # Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcesss" angegebenen Moduls importiert werden sollen.
    # NestedModules = @()
    
    # Aus diesem Modul zu exportierende Funktionen
    FunctionsToExport = '*'
    
    # Aus diesem Modul zu exportierende Cmdlets
    CmdletsToExport = '*'
    
    # Die aus diesem Modul zu exportierenden Variablen
    VariablesToExport = '*'
    
    # Aus diesem Modul zu exportierende Aliase
    AliasesToExport = '*'
    
    # Aus diesem Modul zu exportierende DSC-Resssourcen
    # DscResourcesToExport = @()
    
    # Liste aller Module in diesem Modulpaket
    # ModuleList = @()
    
    # Liste aller Dateien in diesem Modulpaket
    # FileList = @()
    
    # Die privaten Daten, die an das in "RootModule/ModuleToProcesss" angegebene Modul uebergeben werden sollen. Diese koennen auch eine PSData-Hashtabelle mit zusaetzlichen von PowerShell verwendeten Modulmetadaten enthalten.
    PrivateData = @{
    
        PSData = @{
    
            # 'Tags' wurde auf das Modul angewendet und unterstuetzt die Modulermittlung in Onlinekatalogen.
            Tags = @('ACL', 'Audit', 'Registry', 'FileSystem', 'AccessControl')
    
            # Eine URL zur Lizenz fuer dieses Modul.
            # LicenseUri = ''
    
            # Eine URL zur Hauptwebsite fuer dieses Projekt.
            ProjectUri = 'https://github.com/lmissel/System.Security.AccessControl.Commands/'
    
            # Eine URL zu einem Symbol, das das Modul darstellt.
            # IconUri = ''
    
            # 'ReleaseNotes' des Moduls
            # ReleaseNotes = ''
    
        } # Ende der PSData-Hashtabelle
    
    } # Ende der PrivateData-Hashtabelle
    
    # HelpInfo-URI dieses Moduls
    HelpInfoURI = 'https://github.com/lmissel/System.Security.AccessControl.Commands/docs'
    
    # Standardpraefix fuer Befehle, die aus diesem Modul exportiert werden. Das Standardpraefix kann mit "Import-Module -Prefix" ueberschrieben werden.
    # DefaultCommandPrefix = ''
    
    }