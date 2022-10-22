cd # Directorio home

# ---------------------- Instala ohmyzsh y el tema 10k

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # Instala ohmyzsh via curl

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k # Instala powerlevel10k

# ---------------------- Descarga los plugins de zsh

# Autosuggestions  zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # Auto completado de comandos anteriores

# ---------------------- Instala el tema dracula en gnome-terminal

gnomeTerminalVersion=$(gnome-terminal --version)

if [[ "$gnomeTerminalVersion" == *"$errorString"* ]]; then
    echo "Continua ..."
else
    echo "Instalando el tema dracula a gnome-terminal ....."
    git clone https://github.com/dracula/gnome-terminal # Copia el repositorio de dracula
    cd gnome-terminal                                   # Entra a la carpeta del repositorio
    ./install.sh                                        # Instala el tema
fi

# --------------------- Configuracion final

cd "${pathBase}/zsh" # Buscar el archivo de configuracion de zsh

cp .zshrc ~ # Copiar el archivo de configuracion a la ruta home

chsh -s /bin/zsh # Establecer zsh como predeterminada
