# Description

Automate GrapheneOS [CLI](https://grapheneos.org/install/cli#post-installation) installation.

# Quick Start

```bash
git clone https://github.com/MikeHorn-git/GrapheneOS-auto.git
cd GrapheneOS-auto/
```

## Env

Export your targeted DEVICE_NAME and VERSION from [releases](https://grapheneos.org/releases)

```bash
export DEVICE_NAME="tokay"
export VERSION="2025030300"
```

## Install

Now your ready, follow the [guide](https://grapheneos.org/install/cli) and check [Usage](https://github.com/MikeHorn-git/GrapheneOS-auto?#usage)

# Usage

```makefile
Usage: make <target>
Targets:
  help            Show this help message
  reqs            Install packages requirements for Arch
  images          Retreive and check factory images
  lock            Lock the bootloader
  unlock          Unlock the bootloader
  flash           Flash factory images
  clean           Remove factory images folders
  prune           Remove android-tools package
  distclean       Clean & Prune
```
