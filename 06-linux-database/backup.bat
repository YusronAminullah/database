@echo off
REM Script backup database (Windows)

set DB_NAME=toko_online
set BACKUP_DIR=C:\Portfolio\belajar-database\06-linux-database\backup
set DATE=%date:~10,4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%

mkdir %BACKUP_DIR% 2>nul

"C:\laragon\bin\mysql\mysql-8.0.30-winx64\bin\mysqldump" -u root %DB_NAME% > "%BACKUP_DIR%\backup_%DB_NAME%_%DATE%.sql"

echo Backup selesai: backup_%DB_NAME%_%DATE%.sql