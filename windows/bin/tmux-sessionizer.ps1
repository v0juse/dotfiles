# PowerShell port of stow_files/.local/bin/tmux-sessionizer (for psmux on Windows)
param([string]$Selected)

if (-not $Selected) {
    # add your paths here
    $roots = @("$HOME\repos", "D:\repos", "$HOME\.config") | Where-Object { Test-Path $_ }
    $Selected = Get-ChildItem $roots -Directory -Depth 1 | ForEach-Object FullName | fzf
}

if (-not $Selected) { exit 0 }

$name = (Split-Path $Selected -Leaf) -replace '\.', '_'

tmux has-session -t="$name" 2>$null
if ($LASTEXITCODE -ne 0) {
    if (-not $env:TMUX) {
        # outside tmux: create and attach in this terminal
        tmux new-session -s $name -c $Selected
        exit 0
    }
    tmux new-session -ds $name -c $Selected
}

if ($env:TMUX) { tmux switch-client -t $name } else { tmux attach -t $name }
