#!/bin/bash

#Uses pacman to sync the package database, and install git (required to install yay).
_sync() {
    sudo pacman -Sy git
}

#Installs yay, the AUR installer.
_installYay() {
    if sudo pacman -Qs yay > /dev/null ; then
        echo "yay is already installed!"
    else
        echo "yay is not installed. Will be installed now!"
        git clone https://aur.archlinux.org/yay-git.git ~/yay-git
        cd ~/yay-git
        makepkg -si
        cd ~
        echo "yay has been installed successfully."
    fi
}

_init() {
    _sync;
    _installYay;
}

# Break the package list into instances of < foo=("a b c d"); bar=("e f g h");>
# Write install function such that yay -S is run iteratively over array of [foo, bar, ...]

net=("git  wget  curl  nmap netctl  openssh")
term=("tmux  mc  fzf  exa  tldr  wiki-tui  links")
sys=("htop  neofetch  dust  nmon  sysstat  psensor  hwdetect")
tools=("nano  vim  mutt  kitty  timeshift  downgrade  ventoy-bin")
files=("unrar  unzip  dos2unix  transmission-gtk  qdirstat-bin")
fun=("tetris  nsnake  csol  mtpaint  sl  tty-clock  termdown")
media=("pipewire-alsa  cmus  vlc  mpv  ffmpeg  yt-dlp")
langs=("python-pipx  nodejs  npm")
edit=("audacity  sublime-text-4  sioyek-appimage  qt6-multimedia-ffmpeg  shotcut")
pac=("pacseek-bin  bauh  flatpak  libxcrypt-compat  brew")
desk=("google-chrome  firefox  wayland  gnome")


_setAlias() {
    echo "
    alias install='yay -S'
    alias uninstall='yay -Runs'
    alias update='yay -Syu --ignore linux*'
    alias upgrade='yay -Syu'
    alias apps='bauh'
    alias appstore=pacseek

    alias ai='ollama run llama3'
    alias ai-g='ollama run gemma2:2b'
    alias ai-mini='ollama run qwen:0.5b'
    alias ai-code='ollama run granite-code' "  >> ~/.bashrc
}
#dconf dump /org/gnome/terminal/legacy/profiles:/:
_setProfile() {
    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$1/ $2 $3;
}
_setTerminalProfile() {
    prof=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'");

    _setProfile $prof use-theme-colors false;
    _setProfile $prof background-color '#000000';
    _setProfile $prof foreground-color '#FFFFFF';
    _setProfile $prof use-theme-transparency true; 
    _setProfile $prof use-transparent-background true;   
    _setProfile $prof background-transparency-percent 60
}
_setTerminal() {
    yay -Runs gnome-terminal;
    yay -S gnome-terminal-transparency;
    _setTerminalProfile;
    yay -Runs gnome-console;
}

_setTmux() {
    echo "
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    tmux
    fi "  >> ~/.bashrc
}
_tmuxConf() {
    cd ~;
    git clone https://github.com/gpakosz/.tmux.git;
    ln -s -f .tmux/.tmux.conf;
    cp .tmux/.tmux.conf.local .
}
setWallpaper() {
    mkdir '/.wallpaper';
    cd '/.wallpaper';
    links 't.ly/DF4jV';
    path=$(realpath wallpaper.jpeg)
    gsettings set org.gnome.desktop.background picture-uri file://${path}
    cd ~;
}
_setVol() {
    pactl -- set-sink-volume 0 300%
}
_addBottles() {
    flatpak install flathub com.usebottles.bottles
}

_addFOSSai() {
    curl -fsSL https://ollama.com/install.sh | sh
    ollama pull llama3.1
    ollama pull gemma2:2b
    ollama pull qwen:0.5b
    ollama pull granite-code
    ollama list
}


_installer() {
    declare -n apps
    for apps in net term sys tools files fun media edit langs pac desk; 
        do yay -S $apps; 
    done;
    _setAlias;
    _setTerminalProfile;
    _setTmux;
    _tmuxConf;
    _setVol;
    _setWallpaper;
    _addBottles;
    _addFOSSai;
}


#Use yay to sync AND update all packages on the system, except for kernel packages.
#Do update the kernel as needed, and be prepared to restart then.
_update() {
    yay -Syu --ignore linux*
}

#Exit message and open source license disclaimer.
_endTTY() {
    echo "That has been a complete installation using Omar Streete's install script. MIT License, reuse and modify with no restrictions."
}

_startDesktop() {
    sudo systemctl start gdm.service;
}

_finish() {
    _update
    _endTTY
    _startDesktop
}

#Dev Tools:     code  eclipse-platform  waveterm-bin  nmap  virtualbox  ventoy

#Office Suit:   libreoffice-fresh  thunderbird  pidgin  gimp
#               sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

_init
_installer
_finish