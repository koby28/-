#!/bin/bash
#文件名：ping.sh
#根据你所在的网络修改网段地址：192.168.0

for ip in 192.168.0.{1..255} ;
do
    ping $ip -c 2 &> /dev/null ;
    if [ $? -eq 0 ] ;
    then 
        echo $ip is alive
    fi
done
