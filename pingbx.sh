#!/bin/bash
#文件名：pingbx.sh
#根据你所在的网络修改网段地址：192.168.0 利用并行方式来提高整体执行速度
#可将循环体放入()&。()中的命令会在子shell中运行，而&会将其置入后台

for ip in 192.168.10.{1..255} ;
do
  (
    ping $ip -c 2 &> /dev/null ;
    if [ $? -eq 0 ] ;
    then 
        echo $ip is alive
    fi
  ) &
done

wait
