#!/bin/bash

clear
read -p "masukan Email: " email
read -p "Masukkan Username Panel: " user
read -p "password login " psswd

cd /var/www/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }

# Membuat lokasi baru
php artisan p:user:make <<EOF
yes
$email
$user
$user
$user
$passwd
EOF
clear
echo "====================================================="
echo " "
echo "             add admin panel berhasil "
echo " "
echo "====================================================="
