#!/bin/bash

cd ~

# Backup SQL Database
echo -ne "\r Backup Database \r"
db="database-$(date +"%Y-%m-%d").sql.gz" 
mysqldump --user=root --password=p45sw0rd --host=localhost \
    --all-databases | gzip >$db
echo -en "\r Selesai Membuat Arsip Database..."

# Backup File Website
echo -en "\r Backup Website \r"
web="web-$(date +"%Y-%m-%d").tar.bz2"
tar -cvjSf $web /var/www/clients 2>&1 | 
    while read line; do
        x=$((x+1))
        echo -en "\r Sedang mengarsipkan $x file\r"
    done
echo -en "\r Selesai Membuat Arsip File Website..."

# Upload Database
echo -en "\r Upload Database ke Dropbox... \r"
sh /home/script/dropbox_uploader.sh -q upload $db "/home/script/$db"
echo -en "\r Selesai Mengupload Database... \r"

# Upload File Website
echo -en "\r Upload File Website ke Dropbox... \r"
sh /home/script/dropbox_uploader.sh -q upload $web "/home/script/$web"
echo -en "\r Selesai Mengupload File Website... \r"

# Hapus Arsip Database Lokal
echo -en "\r Menghapus File Backup Database Lokal \r"
rm -rf $db
echo -en "\r File Backup Database Lokal Berhasil Terhapus \r"

# Hapus Arsip File Website Lokal
echo -en "\r Menghapus File Backup Database Lokal \r"
rm -rf $web
echo -en "\r File Backup File Website Lokal Berhasil Terhapus \r"


echo -en "\r Terimakasih sudah menggunakan Script Backup BITS.CO.ID \r"
