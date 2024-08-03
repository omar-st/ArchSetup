# Arch Setup Script

## Omar Streete's Installation Script

A simple bash script designed for Arch Linux users to install a variety of packages with one command.
Specificially, this is the script I wrote to reinstall my programs when I change machines. It is tried and tested.

## Installation Instructions:

1. **Copy the script**: Copy the bash script, or download the file, then save it as `ArchSetup.sh`.
2. **Make the script executable**: `cd` to the right directory, then use the command: `chmod +x ArchSetup.sh`
3. **Run the installation script**: Execute the script using this command: `./ArchSetup.sh`

## Packages Installed

The following packages are installed with one simple command:

* Terminal Tools (`tmux`, `mc`, `fzf`, `exa`, `tldr`, `wiki-tui`, `links`)
* System Tools (`htop`, `neofetch`, `dust`, `nmon`, `sysstat`, `psensor`, `hwdetect`)
* Package Managers (`yay`, `flatpak`, `brew`, `npm`, `pacseek-bin`, `bauh`)
* Desktop Tools (`google-chrome`, `firefox`, `vlc`, `wayland`)

## Additional Features

The script also includes the following features:

* Sets up aliases for `install`, `uninstall`, `update`, and `upgrade`
* Sets aliases to converse with local LLM models.
* Configures a custom terminal profile | see: https://github.com/gpakosz/.tmux
* Installs tmux and configures it to run on startup
* Adds bottles and FOSS AI