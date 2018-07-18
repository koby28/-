#!/bin/bash
check_www(){
    md5sum -c /tmp/md5_www.log > /tmp/result_www.log
    [ ! -f /tmp/result_www.log ]&& echo "/tmp/result_www.log not exist."exit 2
    exec < /tmp/result_www.log
    while read line
    do 
        file = `echo $line|awk -F ' ' 'printf $1'`
        #echo $file
        #echo $result
        [ ! "$result" = "OK" ]&&action "$file" /bin/false
    done
}

main(){
    while true
    do
        LANF=en
        [ -f /etc/init.d/functions ]&& . /etc/init.d/functions
        [ ! -f /tmp/md5_www.log ]&& echo "/tmp/md5_www.log not exist."&&exit 1
        check_www 
        action "Alii check done." /bin/true
        sleep 3m
    done
}

main
