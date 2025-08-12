;------------------------------------------------------------
;  Setup.iss – VERTEX Environment Setup
;  Gera instalador Windows com tela de consentimento
;------------------------------------------------------------
#define MyAppName      "VERTEX Environment Setup"
#define MyAppVersion   "1.0.0"
#define MyPublisher    "Isaric SA HUB"
#define LicenseFile    "consent.txt"

[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyPublisher}
DefaultDirName={autopf}\{#MyAppName}
; Não instalamos binários permanentes (apenas rodamos o .ps1)
DisableProgramGroupPage=yes
DisableReadyMemo=yes
OutputDir=.\output
OutputBaseFilename=VERTEX_Setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
WizardStyle=classic
LicenseFile={#LicenseFile}
Uninstallable=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"

[Files]
; Copia o PS1 para a pasta temporária do instalador
Source: "setup_env.ps1"; DestDir: "{tmp}"; Flags: deleteafterinstall

; Recursively copy everything da pasta local "Vertex" para {app}\VERTEX
Source: ".\VERTEX-66db880\*"; DestDir: "{app}\VERTEX"; \
       Flags: recursesubdirs createallsubdirs

[Run]
; Executa o script PowerShell e aguarda término
Filename: "powershell.exe"; Parameters: "-NoLogo -NoProfile -ExecutionPolicy Bypass -File ""{tmp}\setup_env.ps1"" -InstallDir ""{app}"""; StatusMsg: "Configurando ambiente Python e VERTEX..."; Flags: waituntilterminated