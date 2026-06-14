#!/bin/bash
# Script backup otomatis database

# Konfigurasi
USER="root"
PASSWORD=""
DATABASE="toko_online"
BACKUP_DIR="C:\Portfolio\belajar-database\04-backup-recovery\backup"

# Buat folder backup jika belum ada
mkdir -p $BACKUP_DIR

# Buat nama file dengan tanggal
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE_NAME="$BACKUP_DIR/backup_${DATABASE}_${DATE}.sql"

# Eksekusi backup
mysqldump -u $USER $DATABASE > $FILE_NAME

# Hapus backup lama (lebih dari 7 hari)
find $BACKUP_DIR -name "backup_*.sql" -mtime +7 -delete

echo "Backup selesai: $FILE_NAME"