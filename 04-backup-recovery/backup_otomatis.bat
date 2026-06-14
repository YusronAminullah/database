@echo off
set BACKUP_DIR=C:\Portfolio\belajar-database\04-backup-recovery\backup
set DATE=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
set FILE_NAME=%BACKUP_DIR%\backup_toko_online_%DATE%.sql

mkdir %BACKUP_DIR% 2>nul

"C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysqldump" -u root toko_online > %FILE_NAME%

echo Backup selesai: %FILE_NAME%