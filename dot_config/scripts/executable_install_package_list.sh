#!/bin/bash

if ! command -v yay &> /dev/null
then
    echo "Yay is not installed"
    exit 1
fi

PACKAGE_LIST="$HOME/.config/scripts/package_list.txt"
if [ ! -f "$PACKAGE_LIST" ]; then
    echo "Package list '$PACKAGE_LIST' not found"
    exit 1
fi

echo "Installing packages from $PACKAGE_LIST..."
while IFS= read -r package
do
    if [[ -z "$package" || "$package" =~ ^# ]]; then
        continue
    fi
    yay -S --noconfirm --needed "$package"
done < "$PACKAGE_LIST"

# Fix dolphin "open file with" stuff
curl -L https://raw.githubusercontent.com/KDE/plasma-workspace/master/menu/desktop/plasma-applications.menu -o $HOME/.config/menus/applications.menu
kbuildsycoca6

echo "Installation complete 😊"
