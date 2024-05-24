#!/usr/bin/env bash

echo -e "\e[35m Welcome to Pinku Theme installation\e[0m"
wget https://pinku.igarrux.com/pinku-theme.omp.json -qO pinku-theme.omp.json

# check if oh-my-posh is installed
echo "Verifying that oh-my-posh is installed"
if command -v "oh-my-posh" &>/dev/null; then
    echo "\e[96moh-my-posh ✅\e[0m"
else
    echo "\e[33moh-my-posh is not installed, installing...\e[0m"
    echo "executing oh-my-posh installation"
    curl -s https://ohmyposh.dev/install.sh | bash -s

fi

# Move theme to oh-my-posh themes folder
mkdir -p ~/.oh-my-posh/themes
mv ./pinku-theme.omp.json ~/.oh-my-posh/themes

# Config oh-my-posh ant theme
echo -e "\e[35mConfiguring the theme...\e[0m"

if command -v "bash" &>/dev/null; then
    echo "eval \"\$(oh-my-posh init bash --config '~/.oh-my-posh/themes/pinku-theme.omp.json')\"" >>~/.profile
    echo "eval \"\$(oh-my-posh init bash --config '~/.oh-my-posh/themes/pinku-theme.omp.json')\"" >>~/.bashrc
    bash
fi 

if command -v "zsh" &>/dev/null; then
    echo "eval \"\$(oh-my-posh init zsh --config '~/.oh-my-posh/themes/pinku-theme.omp.json')\"" >>~/.zshrc
    zsh
fi

if command -v "fish" &>/dev/null; then
    echo "oh-my-posh init fish --config ~/.oh-my-posh/themes/pinku-theme.omp.json | source" >>~/.config/fish/config.fish
    echo "i love fish"
    fish
fi


echo -e "\e[35m🎉 Congratulations! You already have oh-my-posh and the pinku theme. \e[0m"
echo "now just configure the font in your terminal, you can see a tutorial at https://configs.igarrux.com/terminal-font"
echo "https://configs.igarrux.com is unavailable "