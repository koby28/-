#!/bin/bash
Port=3306
check_db(){
    [ -f /etc/init.d/functions ] && ./etc/init.d/functions
    #if [ `lsof -i:$Port | wc -l` -gt 1 ];then
    #if [ "`netstat -tunlp | grep 3306 | wc -l`" = "1" ];then
    if [ `mysql -uroot -pRedhat1234! -hlocalhost -P $Port -e "show databases;" |wc -l` -gt 1]
        action "Mysql $Port online" /bin/true
    else
        action "Mysql $Port down" /bin/false
    fi
}

main(){
    while true
    do
        check_db
        sleep 1m
    done
}

main
