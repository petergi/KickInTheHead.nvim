# KickInTheHead.nvim

## Introduction

### A Kitchen Sink personal configuration for Neovim that is:

- Originally forked from Kickstart.nvim
- NOT Small
- NOT Single-file
- PARTIALLY Documented

*NOT* a Neovim distribution, but instead my attempt at creating my favorite frankenstein configuration for my own personal use. 
You're welcome to take it and do as you will, over even try to contribute back (if ain't got no other habits, why not?)

## Installation

### Install Neovim

*KickInTheHead.nvim* targets only the latest
'stable' and latest
'nightly' of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

#### External Requirements:

- Basic utils: git, make, unzip, C Compiler (gcc)
- ripgrep
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A Nerd Font: optional, provides various icons
  - if you have it set vim.g.have_nerd_font in init.lua to true
- Language Setup:
  - If want to write Typescript, you need npm
  - If want to write Golang, you will need go
  - etc.

*NOTE*
See Install Recipes for additional Windows and Linux specific notes
and quick install snippets

### Install KickInTheHead

*NOTE*
Backup your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

  OS                  	PATH                                 
  Linux, MacOS        	$XDG_CONFIG_HOME/nvim, ~/.config/nvim
  Windows (cmd)       	%userprofile%\AppData\Local\nvim\    
  Windows (powershell)	$env:USERPROFILE\AppData\Local\nvim\ 

Recommended Step

Fork this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

*NOTE*
Your fork's url will be something like this:
https://github.com/<your_github_username>/kickinthehead.nvim.git

Clone KickInTheHead.nvim

*NOTE*
If following the recommended step above (i.e., forking the repo), replace
petergi with <your_github_username> in the commands below

<details><summary> Linux and Mac </summary>

    git clone https://github.com/petergi/KickInTheHead.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

</details>

<details><summary> Windows </summary>

If you're using cmd.exe:

    git clone https://github.com/petergi/KickInTheHead.nvim.git %userprofile%\AppData\Local\nvim\

If you're using powershell.exe

    git clone https://github.com/petergi/KickInTheHead.nvim.git $env:USERPROFILE\AppData\Local\nvim\

</details>

## Post Installation

### Start Neovim

    `nvim`

That's it! Lazy will install all the plugins you have configured. Use :Lazy to view
current plugin status. Hit q to close the window.

Read through the CONFIGUREME.md file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

## Getting Started

The Only Video You Need to Get Started with Neovim

## Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the Install KickInTheHead step.

### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See telescope-fzf-native documentation for more details

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

    {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

</details>

<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install chocolatey
either follow the instructions on the page or use winget,
run in cmd as admin:

    winget install --accept-source-agreements chocolatey.chocolatey

2. install all requirements using choco, exit previous cmd and
  open a new one so that choco path is set, and run in cmd as admin:

    choco install -y neovim git ripgrep wget fd unzip gzip mingw make

</details>

<details><summary>WSL (Windows Subsystem for Linux)</summary>

    wsl --install
    wsl
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip neovim

</details>

### Linux Install

<details><summary>Ubuntu Install Steps</summary>

    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip neovim

</details>

<details><summary>Debian Install Steps</summary>

    sudo apt update
    sudo apt install make gcc ripgrep unzip git xclip curl
    
    # Now we install nvim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim-linux64
    sudo mkdir -p /opt/nvim-linux64
    sudo chmod a+rX /opt/nvim-linux64
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    
    # make it available in /usr/local/bin, distro installs to /usr/bin
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/

</details>

<details><summary>Fedora Install Steps</summary>

    sudo dnf install -y gcc make git ripgrep fd-find unzip neovim

</details>

<details><summary>Arch Install Steps</summary>

    sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim

</details>  
