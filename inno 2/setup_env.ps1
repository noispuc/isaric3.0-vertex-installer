<#
    setup_env.ps1
    Executado pelo instalador com privilégios de administrador.
    - Instala Git e pyenv-win via winget
    - Instala a versão mais recente do Python
    - Clona o repositório VERTEX
    - Instala dependências via pip
    - Registra log de cada etapa em %TEMP%\vertex-setup.log
#>

# --- Configurações iniciais --------------------------
param(
    [Parameter(Mandatory=$true)]
    [string]$InstallDir
)

$VertexRepoUrl = "https://github.com/ISARICResearch/VERTEX.git"
$VertexDir = Join-Path $InstallDir "VERTEX"
Write-Host "$VertexDir"

# --- Logging -----------------------------------------
$LogFile = Join-Path $Env:TEMP "vertex-setup.log"
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format u
    Add-Content -Path $LogFile -Value "$timestamp - $Message"
    Write-Host "[VERTEX-Setup] $Message"
}

$ErrorActionPreference = 'Stop'
Write-Log "=== Início da instalação VERTEX ==="

try {
    # 1. Verificar winget
    Write-Log "Verificando winget..."
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw "winget não encontrado. Instale o App Installer e tente novamente."
    }

    # 2. Instalar Git
    # Write-Log "Instalando Git..."
    # winget install --id Git.Git -e --scope machine --accept-package-agreements --accept-source-agreements --silent
    # Write-Log "Git instalado com sucesso."

    # 2. Instalar pyenv-win via script oficial
    $installScript = Join-Path $Env:TEMP "install-pyenv-win.ps1"
    Write-Log "Baixando install-pyenv-win.ps1 do repositório oficial..."
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile $installScript
    Write-Log "Executando script de instalação do pyenv-win..."
    & $installScript
    Write-Log "pyenv-win instalado com sucesso via script oficial."

    # 3. Configurar PATH para pyenv-win nesta sessão
    Write-Log "Configurando variáveis de ambiente para pyenv-win..."
    $pyEnvRoot = Join-Path $env:USERPROFILE ".pyenv\pyenv-win"
    [System.Environment]::SetEnvironmentVariable('PYENV', $pyEnvRoot, 'User')
    [System.Environment]::SetEnvironmentVariable('PYENV_ROOT', $pyEnvRoot, 'User')
    [System.Environment]::SetEnvironmentVariable('PYENV_HOME', $pyEnvRoot, 'User')
    [System.Environment]::SetEnvironmentVariable('Path', "$pyEnvRoot\bin;$pyEnvRoot\shims;" + [System.Environment]::GetEnvironmentVariable('Path', 'User'), 'User')
    Write-Log "Variáveis de ambiente para pyenv-win configuradas."
	
	Write-Log "Atualizando o PATH manualmente..."
	$env:Path = "$pyenvRoot\bin;$pyenvRoot\shims;$env:Path"


    # 4. Instalar Python mais recente via pyenv
    Write-Log "Buscando versão mais recente do Python via pyenv..."
    $latest = 3.12.6
    Write-Log "Instalando Python $latest..."
    pyenv install 3.12.6
    pyenv global 3.12.6
    Write-Log "Python $latest instalado e configurado globalmente via pyenv."

    # 5. Definir comando Python (py launcher)
    $pythonCmd = 'python'
    Write-Log "Usando comando Python: $pythonCmd"

    # 6. Verificar instalação Python
    Write-Log "Verificando instalação Python..."
    $pyVerOutput = & $pythonCmd --version 2>&1
    Write-Log "Versão instalada: $pyVerOutput"

    # 8. Clonar ou atualizar VERTEX
    # if (-not (Test-Path $VertexDir)) {
    #     Write-Log "Clonando repositório VERTEX em $VertexDir..."
    #     git clone $VertexRepoUrl $VertexDir
    #     Write-Log "Repositório VERTEX clonado."
    # } else {
    #     Write-Log "Repositório já existe em $VertexDir - atualizando..."
    #     Push-Location $VertexDir
    #     git pull
    #     Pop-Location
    #     Write-Log "Repositório VERTEX atualizado."
    # }
	
	# 7. Verificar instalação VERTEX
	if (-not (Test-Path $VertexDir)) {
		throw "Diretório VERTEX não encontrado em $VertexDir. Verifique o instalador."
	} else {
		Write-Log "Usando VERTEX pré-embutido em $VertexDir."
	}

    # 8. Instalar dependências do VERTEX via pip
    Write-Log "Instalando dependências do VERTEX via pip..."
    & $pythonCmd -m pip install --upgrade pip
    & $pythonCmd -m pip install -r (Join-Path $VertexDir "requirements.txt")
    Write-Log "Dependências instaladas com sucesso."

    Write-Log "=== Instalação concluída com sucesso! ==="
}
catch {
    $err = $_.Exception.Message
    Write-Log ("=== ERRO: " + $err + " ===")
    $userInput = Read-Host "Digite algo para continuar..."
    exit 1
}
