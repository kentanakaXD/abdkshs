#!/bin/bash

clear
# Minta input domain untuk panel
read -p "Masukkan domain panel (misalnya, panel.example.com): " panel_domain

# Minta input domain untuk node
read -p "Masukkan domain node, (misalnya, node.example.com): " node_domain
clear
# Jalankan installer Pterodactyl tanpa SSL otomatis
echo "Memulai instalasi Pterodactyl..."
bash <(curl -s https://pterodactyl-installer.se) <<EOF
0


maulana
Asia/Jakarta
maulana@gmail.com
maulana@gmail.com
maulana
maulana
maulana
maulana
$panel_domain
y
y
y
y
yes
n # Skip Let's Encrypt
n # Skip SSL for now
EOF

# Konfigurasi Let's Encrypt setelah instalasi
echo "Mengonfigurasi SSL dengan Let's Encrypt..."
certbot --nginx --redirect --agree-tos --no-eff-email --email maulana@gmail.com --non-interactive -d $panel_domain

clear
# Tetapkan nama lokasi, nama node, RAM, disk space, dan location ID secara default
location_name="sg"
location_description=" "
node_name="NODE"
ram="16000000"
disk_space="16000000"
locid="1"

# Ubah ke direktori pterodactyl
echo "Mengubah direktori ke /var/www/pterodactyl..."
cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
echo "Membuat lokasi baru..."
php artisan p:location:make <<EOF
$location_name
$location_description
EOF

# Membuat node baru
echo "Membuat node baru..."
php artisan p:node:make <<EOF
$node_name
$location_description
$locid
https
$node_domain
yes
no
no
$ram
0
$disk_space
0
100
8080
2022
/var/lib/pterodactyl/volumes
EOF

# Jalankan installer Pterodactyl dengan input otomatis kecuali untuk domain
echo "Memulai instalasi Pterodactyl..."
bash <(curl -s https://pterodactyl-installer.se) <<EOF
1
y
y
y

y

maulana
y
$node_domain
y
maulana@gmail.com
y
EOF
# Bersihkan layar dan tampilkan pesan akhir
clear
echo "====================================================="
echo " "
echo "     Install panel dan pembuatan node selesai"
echo " "
echo "====================================================="
echo " "
echo " "
echo "====================================================="
echo " "
echo "                  Data Panel Anda: "
echo "       Domain   : $panel_domain "
echo "       Username : maulana"
echo "       Password : maulana"
echo " "
echo "====================================================="
