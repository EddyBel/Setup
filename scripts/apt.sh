# ------------------ Actualiza los paquetes
sudo apt update &
sudo apt upgrade -y

# ------------------ Instala los paquetes basicos

sudo apt install git nodejs npm zsh curl -y # Instala los paquetes basicos

# ------------------ Paquetes apt opcionales

echo "--------------------------"
echo "Instala paquetes apt obcionales"
echo "--------------------------"
echo ""
echo "blender, htop, neofetch"
read -p "Instalar todos los paquetes? y/n " installAptGlobal

if [[ "$installAptGlobal" == "y" ]]; then
    echo "--------------------------"
    echo "Instalando todos ......"
    echo "--------------------------"
    sudo apt install blender htop neofetch -y # Instala todos los paquetes
else
    echo "--------------------------"
    echo "Preguntando la instalacion"
    echo "--------------------------"
    echo ""
    read -p "Instalar blender? y/n " blender
    read -p "Instalar htop? y/n " htop
    read -p "Instalar neofetch? y/n " neofetch

    # Validar cada instalacion

    if [[ "$blender" == "y" ]]; then
        sudo apt install blender -y
    else
        echo "Continua ......"
    fi

    if [[ "$htop" == "y" ]]; then
        sudo apt install htop -y
    else
        echo "Continua ......"
    fi

    if [[ "$blender" == "y" ]]; then
        sudo apt install neofetch -y
    else
        echo "Continua ......"
    fi

fi
