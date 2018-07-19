#!/bin/bash
#mysql的分库备份脚本mysql-differ-database-backups.sh 的脚本

MYUSER=root
MYPASS=password
SOCKET="/var/lib/mysql/mysql.sock"
MYCMD="mysql -u$MYUSER -p$MYPASS"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS"
BACKUP_DIR="/work/backup/mysql"

for database in `$MYCMD -e "show databases;" | sed '1,2d' | egrep -v "mysql | schema"`
do
    if [ ! -f $BACKUP_DIR/${database} ];then
        mkdir -p $BACKUP_DIR/${database}
    fi
    $MYDUMP ${database} | grep > $BACKUP_DIR/${database}_`date +%F`.tar.gz
done 
