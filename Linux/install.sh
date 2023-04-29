#!/bin/bash

# Manager packages to be installed
packages=("neofetch" "htop" "xclip" "zsh" "curl")

# Validates if the "apt" package manager is on the system.
if [ -x "$(command -v apt)" ]; then
  echo 'APT manager is installed'

  sudo apt update
  sudo apt upgrade -y

  # The first thing to do is to install the packages of the manager installed on the system.
  # You can install all of them at once or ask for the installation of each one independently.
  for package in "${packages[@]}"; do
    echo $package
  done

  # Ask if you want to install all the packages in the list
  read -p "Do you want to install all packages? (y/n): " install_all
  if [[ $install_all =~ ^[yY]$ ]]; then

    # Install all the packages in the list
    for package in "${packages[@]}"; do
      echo "Installing $package"
      sudo apt install $package
    done

  else
    # Installs only the packages that the user wants
    for package in "${packages[@]}"; do
      read -p "¿You want to install the package $package? (y/n): " package_choice
      if [[ $package_choice =~ ^[yY]$ ]]; then
        sudo apt install $package
      fi
    done
  fi 
else
  echo 'APT is not installed on the system.'
fi

# Validates if the "pacman" package manager is on the system.
if [ -x "$(command -v pacman)" ]; then
  echo 'Pacman está instalado en el sistema.'

  # The first thing to do is to install the packages of the manager installed on the system.
  # You can install all of them at once or ask for the installation of each one independently.
  for package in "${packages[@]}"; do
    echo $package
  done

  # Ask if you want to install all the packages in the list
  read -p "Do you want to install all packages? (y/n): " install_all
  if [[ $install_all =~ ^[yY]$ ]]; then

    # Install all the packages in the list
    for package in "${packages[@]}"; do
      echo "Installing $package"
      sudo pacman -S $package
    done

  else
    # Installs only the packages that the user wants
    for package in "${packages[@]}"; do
      read -p "¿You want to install the package $package? (y/n): " package_choice
      if [[ $package_choice =~ ^[yY]$ ]]; then
        sudo pacman -S $package
      fi
    done
  fi 
else
  echo 'Pacman no está instalado en el sistema.'
fi

# In this section neovim will be installed as the main code editor.
if [ -x "$(command -v nvim)" ]; then
  echo 'Neovim is installed on the system.'

  # Download and move the neovim configuration files from the repository
  git clone https://github.com/EddyBel/NeoVim-config.git
  mkdir ~/.config/nvim
  mv NeoVim-config/init.lua ~/.config/nvim/
  mv NeoVim-config/lua ~/.config/nvim/

else
  echo 'Neovim is not installed on the system.'

  # Install neovim using the repository to get the latest version
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  ./squashfs-root/AppRun --version
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  
  # Download and move the neovim configuration files from the repository
  git clone https://github.com/EddyBel/NeoVim-config.git
  mkdir ~/.config/nvim
  mv NeoVim-config/init.lua ~/.config/nvim/
  mv NeoVim-config/lua ~/.config/nvim/
fi

# Install the fonts that I can use on my systems.
cp -R fonts/* . # Copiar las fuentes a la carpeta actual
sudo mv * /usr/share/fonts/ # Mover las fuentes al directorio /usr/share/fonts
sudo fc-cache -f -v # Actualizar la caché de fuentes

# Install nodejs to its latest version
if [ -x "$(command -v node)" ]; then
  echo 'Node.js is installed on the system.'

  # Update Node version
  # Use NVM as Node's version manager
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install node --reinstall-packages-from=node
  nvm uninstall $(nvm current)
  node -v npm -v
else
  echo 'Node.js is not installed on the system.'

  # Install the latest version of Node
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install node
  node -v npm -v
fi

if [ -x "$(command -v deno)" ]; then
  echo 'Deno está instalado en el sistema.'
  curl -fsSL https://deno.land/x/install/install.sh | sh
else
  echo 'Deno no está instalado en el sistema.'
fi

# Install the "zsh" configuration and its plugins and layout configuration.
if [ -x "$(command -v zsh)" ]; then
  echo 'ZSH is installed in the system.'
  
  # Move the configuration to where it belongs
  sudo mv .zshrc ~
  # Install PLUGIN Autosuggestions
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  # Install PLUGIN zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  # Install theme PowerLevel10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  # Set zsh as primary
  chsh -s /bin/zsh
  # Install ZSH
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo 'ZSH is not installed on the system.'
fi
