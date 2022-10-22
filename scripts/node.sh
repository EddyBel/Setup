# ------------------ Actualiza nodejs

echo "Version de NodeJS: $(node --version)"

sudo npm install -g n # Insalta de manera global el paquete para actualizar

# Instala la ultima version
sudo n lts
sudo n latest

# Elimina la version previa
sudo n prune
sudo apt remove nodejs -y

echo "Version de NodeJS: $(node --version)"

# ------------------- Actualiza npm

echo "Version de NPM: $(npm --version)"

npm install -g npm@latest # Descarga la ultima version de npm

echo "Version de NPM: $(npm --version)"

# ------------------- Descarga paquetes adicionales globales

sudo npm install -g yarn # Instala yarn

echo "Version de YARN: $(yarn --version)"
