**Arch Setup Script**

# Omar Streete's Installation Script

A simple bash script designed for Arch Linux users to install a variety of packages with one command.
Specificially, this is the script I wrote to reinstall my programs when I change machines. It is tried and tested.

## Installation Instructions:

1. **Copy the script**: Copy the below bash script into your text editor, then save it as `install.sh`.
2. **Make the script executable**: Use the following terminal command: `chmod +x ./install.sh`
3. **Run the installation script**: Execute the script using this command: `./install.sh`

## Packages Installed

The following packages are installed with one simple command:

* Terminal Tools (`tmux`, `mc`, `fzf`, `exa`, `tldr`, `wiki-tui`, `links`)
* System Tools (`htop`, `neofetch`, `dust`, `nmon`, `sysstat`, `psensor`, `hwdetect`)
* Package Managers (`pacseek-bin`, `bauh`, `flatpak`)
* Desktop Tools (`google-chrome`, `firefox`, `wayland`)

## Additional Features

The script also includes the following features:

* Sets up aliases for `install`, `uninstall`, `update`, and `upgrade`
* Configures a custom terminal profile
* Installs tmux and configures it to run on startup
* Adds bottles and FOSS AI