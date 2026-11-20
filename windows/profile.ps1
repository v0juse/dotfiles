# Dot-sourced from the PowerShell profile by kickstart.ps1 (Windows counterpart of .zshrc)
$dotfiles = Split-Path $PSScriptRoot -Parent

Set-Alias lg lazygit
Set-Alias n nvim
Set-Alias v nvim
Set-Alias t tmux-sessionizer
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Remove-Item Alias:cat -Force -ErrorAction SilentlyContinue
    Set-Alias cat bat
}

$env:EDITOR = 'nvim'
$env:RIPGREP_CONFIG_PATH = "$dotfiles\stow_files\.ripgreprc"

# zsh-autosuggestions equivalent (PSReadLine 2.1+, ships with PowerShell 7)
if ((Get-Module PSReadLine).Version -ge [version]'2.1') {
    Set-PSReadLineOption -PredictionSource History
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
