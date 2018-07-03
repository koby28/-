#!/bin/bash
#文件名：pcpu_usage.sh
#计算一小时内CPU使用情况

#将SECS更改成需要进行监视的总秒数
#UNIT_TIME是取样的时间间隔，单位是秒

SECS=3600
UNIT_TIME=60

STEPS=$(( $SECS / $UNIT_TIME ))

echo Watching CPU usage... ;

#采集数据，存入临时文件
for (( i=0;i<STEPS;i++ ))
do
    ps -eocomm,pcpu | egrep -v ' (0.0) | (%CPU) ' >> /tmp/cpu_usage.$$
    sleep $UNIT_TIME
done

#处理采集到的数据

echo
echo CPU eaters ;


cat /tmp/cpu_usage.$$ | awk '{ process[$1]+=$2; } END{ for (i in process){ printf("%-20s %s\n",i, process[i]);}}' | sort -nrk 2 | head


#删除临时日志文件
rm /tmp/cpu_usage.$$
