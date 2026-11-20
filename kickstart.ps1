# Windows counterpart of kickstart.sh. Idempotent, no admin needed.
# Usage: powershell -ExecutionPolicy Bypass -File .\kickstart.ps1
$repo = $PSScriptRoot

function Update-SessionPath {
    $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' +
                [Environment]::GetEnvironmentVariable('Path', 'User')
}

# Installing CLI tools
$packages = @(
    'Neovim.Neovim'
    'marlocarlo.psmux'           # tmux for Windows
    'Microsoft.PowerShell'       # pwsh 7, psmux default shell
    'junegunn.fzf'
    'sharkdp.fd'
    'BurntSushi.ripgrep.MSVC'
    'sharkdp.bat'
    'eza-community.eza'
    'ajeetdsouza.zoxide'
    'JesseDuffield.lazygit'
    'zig.zig'                    # C compiler for nvim-treesitter parsers
)
foreach ($id in $packages) {
    winget list -e --id $id --accept-source-agreements *> $null
    if ($LASTEXITCODE -eq 0) { continue }
    Write-Host "Installing $id"
    winget install -e --id $id --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) { Write-Warning "winget failed for $id (exit $LASTEXITCODE)" }
}
Update-SessionPath

# Install nerd font
# NOTE: It is likely that you will need to choose the font on the terminal settings
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    $scoopApps = Join-Path (Split-Path (Split-Path (Get-Command scoop).Source)) 'apps'
    if (-not (Test-Path "$scoopApps\FiraCode-NF-Mono")) {
        Write-Host "Installing FiraCode Nerd Font"
        if (-not (scoop bucket list | Where-Object Name -eq 'nerd-fonts')) { scoop bucket add nerd-fonts }
        scoop install nerd-fonts/FiraCode-NF-Mono
    }
    # tree-sitter CLI for nvim-treesitter (npm package needs install scripts allowed)
    if (-not (Test-Path "$scoopApps\tree-sitter")) { scoop install main/tree-sitter }
} else {
    Write-Warning "scoop not found, skipping nerd font and tree-sitter (https://scoop.sh)"
}

# Packages for neovim
if (Get-Command npm -ErrorAction SilentlyContinue) {
    npm ls -g neovim --depth 0 *> $null
    if ($LASTEXITCODE -ne 0) { npm install -g neovim }
} else {
    Write-Warning "npm not found, skipping neovim npm package"
}

# Link neovim config (junction: no admin or Developer Mode needed)
$nvimTarget = Join-Path $repo 'stow_files\.config\nvim'
$nvimLink = Join-Path $env:LOCALAPPDATA 'nvim'
$existing = Get-Item $nvimLink -ErrorAction SilentlyContinue
if (-not $existing) {
    Write-Host "Linking $nvimLink -> $nvimTarget"
    New-Item -ItemType Junction -Path $nvimLink -Target $nvimTarget | Out-Null
} elseif ($existing.LinkType -ne 'Junction' -or $existing.Target -notcontains $nvimTarget) {
    Write-Warning "$nvimLink already exists and is not linked to the dotfiles, leaving it alone"
}

# psmux config: shared .tmux.conf, then Windows overrides
$psmuxConf = Join-Path $HOME '.psmux.conf'
$marker = '# managed by dotfiles/kickstart.ps1'
$psmuxStub = @(
    $marker
    "source-file `"$((Join-Path $repo 'stow_files\.tmux.conf') -replace '\\', '/')`""
    "source-file `"$((Join-Path $repo 'windows\psmux.conf') -replace '\\', '/')`""
)
if (-not (Test-Path $psmuxConf) -or (Get-Content $psmuxConf -TotalCount 1) -eq $marker) {
    Set-Content -Path $psmuxConf -Value $psmuxStub -Encoding ASCII
} else {
    Write-Warning "$psmuxConf exists and is not managed by kickstart.ps1, leaving it alone"
}

# Put windows\bin (tmux-sessionizer) on the user PATH, like ~/.local/bin on linux
$bin = Join-Path $repo 'windows\bin'
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
if (($userPath -split ';') -notcontains $bin) {
    Write-Host "Adding $bin to user PATH"
    [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ";$bin"), 'User')
    Update-SessionPath
}

# Hook profile.ps1 into Windows PowerShell 5.1 and PowerShell 7 profiles
$docs = [Environment]::GetFolderPath('MyDocuments')
$profileLine = ". `"$(Join-Path $repo 'windows\profile.ps1')`""
foreach ($p in @("$docs\WindowsPowerShell\Microsoft.PowerShell_profile.ps1",
                 "$docs\PowerShell\Microsoft.PowerShell_profile.ps1")) {
    if ((Test-Path $p) -and (Get-Content $p) -contains $profileLine) { continue }
    Write-Host "Hooking dotfiles profile into $p"
    New-Item -ItemType Directory -Force -Path (Split-Path $p) | Out-Null
    Add-Content -Path $p -Value $profileLine -Encoding ASCII
}

Write-Host "Done. Open a new terminal, pick 'FiraCode Nerd Font Mono' in the terminal settings, then run 't' or 'tmux'."
