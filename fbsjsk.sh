#!/bin/bash

clear
#minta akses token kepengguna
read -p "Masukkan token untuk konfigurasi wings: " token
# Konfigurasi Wings
echo "Mengonfigurasi Wings..."
cd /etc/pterodactyl || { echo "Direktori tidak ditemukan"; exit 1; }
sudo wings configure --panel-url https://$node_domain --token $token --node 1

# Mulai layanan Wings
echo "Memulai layanan Wings..."
sudo systemctl start wings

clear
echo "====================================================="
echo " "
echo "             start wings telah selesai "
echo " "
echo "====================================================="
