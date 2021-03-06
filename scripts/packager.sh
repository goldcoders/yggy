#!/bin/sh
# use on linux to check if we have curl
# if we have curl we can use webi installer
packagesNeeded='curl jq'
if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
if [ -x "$(command -v yum)" ];       then sudo yum install $packagesNeeded
elif [ -x "$(command -v apt)" ];     then sudo apt install $packagesNeeded
elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
elif [ -x "$(command -v pacman)" ];  then sudo pacman -S $packagesNeeded
elif [ -x "$(command -v nix-env)" ];  then sudo nix-env -i $packagesNeeded
else echo "FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: $packagesNeeded">&2; fi