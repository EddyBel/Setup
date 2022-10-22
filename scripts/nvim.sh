cd # Directorio home

# ------------------ Descarga neovim

neovimVersion=$(nvim --version)

if [[ "$neovimVersion" == *"$errorString"* ]]; then
    echo "Instalando neovim ....."

    # Instala via curl
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage

    # Define el comando para usar neovim
    ./nvim.appimage --appimage-extract
    ./squashfs-root/AppRun --version

    # Neovim de forma global
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
    nvim

else
    echo "Neovim instalado continua"
fi

echo "Version de Neovim: $(nvim --version)"

# ------------------- Instalar el gestor de instalacion de plugins Vim plug

echo "Instala Vim plug"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# ------------------- Descarga la configuracion de neovim

git clone https://github.com/EddyBel/nvim-configuration.git # Copia de repositorio configuracion

cd nvim-configuration # Entra a la carpeta

mkdir ~/.config/nvim # Crea la carpeta de configuracion

mv init.lua vim lua ~/.config/nvim/ # Mueve los archivos a la carpeta de configuracion

# ------------------- Notas ------------------

# Al terminal abrir la configuracion de neovim con
# cd ~/.config/nvim # moverte a la carpeta de la configuracion
# nvim . # Abrir con neovim la configuracion
# Entrar a la carpeta vim y abrir el archivo "plugged.vim"
# Recargar el archivo con el comando
# :so ~/.config/nvim/vim/plugged.vim
# Ahora se puede instalar los plugins con
# :PluggedInstall
