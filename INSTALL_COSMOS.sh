#!/bin/bash
# ==============================================================================
# COSMOSERP DESKTOP PRODUCT INSTALLER
# ==============================================================================
set -e

# --- PRODUCT SETTINGS ---
DB_PASS="admin123"
ADMIN_PASS="admin123"
S_NAME="cosmos.local"
TOKEN="<YOUR_GITHUB_TOKEN>"
INSTALL_USER="saleelhussain-design"
REPO="cosmos_core"
# ------------------------

# 1. Silent System Setup
sudo apt-get update -y > /dev/null 2>&1
sudo apt-get install -y git python3-dev python3-pip python3-venv mariadb-server redis-server curl nodejs npm > /dev/null 2>&1
sudo npm install -g yarn > /dev/null 2>&1

# 2. Database Configuration
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASS';" > /dev/null 2>&1
sudo mysql -e "FLUSH PRIVILEGES;" > /dev/null 2>&1
sudo bash -c 'cat <<EOF > /etc/mysql/mariadb.conf.d/50-frappe.cnf
[mysqld]
innodb-check-optimize-monitor=ON
innodb-file-per-table=1
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
innodb_file_format=Barracuda
innodb_large_prefix=1
innodb_default_row_format=DYNAMIC
EOF'
sudo systemctl restart mariadb > /dev/null 2>&1
sudo systemctl start redis-server > /dev/null 2>&1

# 3. Install the App Engine (Silently)
SUDO_USER=${SUDO_USER:-$INSTALL_USER}
U_HOME=$(eval echo ~$SUDO_USER)
sudo -u $SUDO_USER bash <<EOF
    export PATH="\$HOME/.local/bin:\$PATH"
    pip3 install --user frappe-bench > /dev/null 2>&1
    cd \$HOME
    if [ ! -d "cosmos-bench" ]; then
        bench init cosmos-bench --frappe-branch version-15 --skip-redis-config-check > /dev/null 2>&1
    fi
    cd cosmos-bench
    if [ ! -d "sites/$S_NAME" ]; then
        bench new-site $S_NAME --mariadb-root-password $DB_PASS --admin-password $ADMIN_PASS > /dev/null 2>&1
    fi
    bench get-app https://$INSTALL_USER:$TOKEN@github.com/$INSTALL_USER/$REPO.git > /dev/null 2>&1
    bench --site $S_NAME install-app $REPO > /dev/null 2>&1
EOF

# 4. Create the Desktop App Icon (The "Non-Web" Experience)
ICON_PATH="$U_HOME/Desktop/CosmosERP.desktop"
sudo -u $SUDO_USER bash -c "cat <<EOD > $ICON_PATH
[Desktop Entry]
Version=1.0
Type=Application
Name=CosmosERP
Exec=bash -c 'cd $U_HOME/cosmos-bench && bench start'
Icon=system-software-install
Terminal=true
Categories=Office;Business;
EOD"
sudo -u $SUDO_USER chmod +x "$ICON_PATH"

echo "------------------------------------------------------------"
echo "SUCCESS! CosmosERP is now installed on your computer."
echo "Look for the 'CosmosERP' icon on your desktop and double-click it."
echo "------------------------------------------------------------"
