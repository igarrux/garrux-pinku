#!/usr/bin/env bash

echo -e "\e[35m Welcome to Pinku Theme installation\e[0m"
wget https://pinku.igarrux.com/pinku-theme.omp.json -qO pinku-theme.omp.json

# check if oh-my-posh is installed

echo "Verifying that oh-my-posh is installed"
echo "export PATH=$PATH:/root/.local/bin" >>~/.bashrc
if command -v "oh-my-posh" &>/dev/null; then
    echo -e "\e[96moh-my-posh ✅\e[0m"
else
    echo -e "\e[33moh-my-posh is not installed, do you want to install it? [Y/n]\e[0m"
    read -r isWantsToInstall

    case $isWantsToInstall in
    n | N)
        echo -e "\e[31mWe continue without installing oh-my-posh, remember that you must install it later.\e[0m"

        ;;
    *)
        echo "executing oh-my-posh installation"
        curl -s https://ohmyposh.dev/install.sh | bash -s
        ;;
    esac
fi

# Move theme to oh-my-posh themes folder
mkdir -p ~/.oh-my-posh/themes
mv ./pinku-theme.omp.json ~/.oh-my-posh/themes

# Config oh-my-posh ant theme
echo -e "\e[35mDo you want to configure the theme? [Y/n]\e[0m"
read -r isWantsToConfig
case $isWantsToConfig in
n | N)
    echo "The theme installed correctly but was not configured. It was saved in: "
    echo "~/.oh-my-posh/themes/pinku-theme.omp.json"
    ;;
*)
    commandLine="eval \"\$(oh-my-posh init bash --config '~/.oh-my-posh/themes/pinku-theme.omp.json')\""
    echo "$commandLine" >>~/.profile
    echo "$commandLine" >>~/.bash_profile
    echo "$commandLine" >>~/.bashrc
    ;;
esac

# Font instalation
echo -e "\e[33mIf you are using WSL skip this step and follow the guide at https://config.garrux.com/install-font \e[0m"
echo -e "\e[32mTo view the icons, FiraCode Nerd Font is recommended, do you want to install it? [Y/n] \e[0m"
read -r isWantsToInstallFont
case $isWantsToInstallFont in
n | N)
    echo "Remember to install a nerd font to display the icons."
    ;;
*)

    # check if oh-my-posh is installed
    echo "Verifying that unzip is installed"
    if command -v "unzip" &>/dev/null; then
        echo -e "\e[96munzip ✅\e[0m"
        echo "Installing font..."

        mkdir -p ~/.local/share/fonts

        # Download the FiraCode Nerd Font file from GitHub
        wget -qO ~/.local/share/fonts/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip

        # Unzip the downloaded file
        unzip ~/.local/share/fonts/FiraCode.zip -d ~/.local/share/fonts

        # Update the system font cache
        fc-cache -f -v ~/.local/share/fonts

        # Clean temporary files
        rm ~/.local/share/fonts/FiraCode.zip
    else
        echo "😿 Unzip is required to install this source, run "sudo apt install unzip" to install it and try again."
        echo "Font link: https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip"
    fi
    ;;

esac
echo -e "\e[35m🎉 Congratulations! You already have oh-my-posh and the pinku theme. \e[0m"
echo "now just configure the font in your terminal, you can see a tutorial at https://configs.igarrux.com/terminal-font"
