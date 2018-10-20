# Menthol - Post installation script for linuxMint

Menthol is a shell script written in bash which will help you to tune fresh installation of [**Linux Mint**](https://www.linuxmint.com/) for better performance and usage. It will also install all programs that you need.

The idea of this script is to automatically recreate full customized experience of your favorite desktop quickly by following simple wizard. We all know how annoying it is when you have to make fresh installation of operating system, spend hours after to install all needed programs and make all configurations to customize your user experience. I came up with idea to automate this process.

This script will guide you through steps, where you will be able to choose which programs you want to perform or tweaks to make by simply ticking them on the list.

The another important principle of this script is to make everything revertible, so you don't have to be afraid of making something that you will regret.  

## Features

- Enable installation of recommended packages (blocked by default on Linux Mint)
- Automatic installation of many programs like **cloud services, IDEs, communicators, text editors, applets** and other utilities
- Import / Export of settings for Thunderbird, Sublime Text

## Installation

* download repository and unzip it in any location you like
* open terminal in location of repository files
* type in terminal:

```bash
sudo bash install.sh
```

* to run script simply click icon in menu, or type in terminal:

```bash
menthol
```

## Uninstallation

* open terminal in location of repository files
* type in terminal:

```bash
sudo bash uninstall.sh
```

* uninstall.sh script will delete all files installed previously