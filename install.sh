echo "--------------------------"
echo "Instalando Setup"
echo "--------------------------"

pathBase=$(pwd) # Ruta actual del folder

# Version de gestor de paquetes apt
aptVersion=$(apt --version)
errorString="command not found"

# Filtrar si apt existe
if [[ "$aptVersion" == *"$errorString"* ]]; then
    echo "No existe apt"
else
    source "${pathBase}/scripts/apt.sh"  # Scripts de apt
    source "${pathBase}/scripts/node.sh" # Scripts de node js
    source "${pathBase}/scripts/nvim.sh" # Scripts de neovim
    source "${pathBase}/scripts/zsh.sh"  # Scripts de zsh
fi
