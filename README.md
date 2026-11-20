# Dotfiles

> This repository contains my initial setup for linux distros, it enables me to
> quickly install my most important packages and tools on a fresh install.
> Currently it only supports Ubuntu/Debian based distros.

## TODOs

- [ ] Test on more Ubuntu/Debian distros (only Ubuntu and Mint were tested)
- [ ] Write an alternative script for other distros (mainly Arch based ones)
- [ ] Improve neovim config
- [ ] Add more packages

## Usage

In order to use it, just run the kickstart script:

```bash
./kickstart.sh
```

If this is the first time running it, you might need to change the terminal font
and restart the machine for the change to take effect.

## Windows

Native Windows setup (no WSL, no admin), run from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\kickstart.ps1
```

It installs the tools with winget/scoop (neovim, [psmux](https://github.com/psmux/psmux)
as `tmux`, fzf, fd, ripgrep, bat, eza, zoxide, lazygit, pwsh 7, zig and tree-sitter
for treesitter, FiraCode Nerd Font) and links the shared configs instead of copying them:

- `%LOCALAPPDATA%\nvim` is a junction to `stow_files/.config/nvim`
- `~/.psmux.conf` sources `stow_files/.tmux.conf` and then `windows/psmux.conf`
- `windows/bin` (PowerShell `tmux-sessionizer`) is added to the user PATH
- `windows/profile.ps1` (aliases, zoxide) is dot-sourced from the PowerShell profiles

The script is idempotent and can be cloned anywhere. Pick the nerd font in the
Windows Terminal settings after the first run.

## NOTE

As stow is used to manage the dotfiles, and it stows it to the previous folder (..),
this repo needs to be cloned in the home folder.
