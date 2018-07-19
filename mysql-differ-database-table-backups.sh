#!/bin/bash
MYUSER=root
MYPASS=password
SOCKET="/var/lib/mysql/mysql.sock"
MYCMD="mysql -u$MYUSER -p$MYPASS"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS"
BACKUP_DIR="/work/backup/mysql"

for database in `$MYCMD -e "show database;"|sed '1,2d' | egrep -v "mysql|schema"`
do
    if [! -f $BACKUP_DIR/${database} ];then
        mkdir -p $BACKUP_DIR/${database}
    fi
    $MYDUMP ${database} | gzip > $BACKUP_DIR/${database}_`date +%F`.tar.gz

    for i in $database
        do
            tables=`$MYCMD -e "use $i;show tables;"|sed 1d`
            for j in $tables
                do
                    MYDUMP   -B --databases $i --tables $j > $BACKUP_DIR/${i}-${j}-`date +%F`.sql
                done
        done
done
