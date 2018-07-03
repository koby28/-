#!/bin/bash
#文件名:intruder_detect.sh
#用途:入侵报告工具，以auth.log作为输入
AUTHLOG=/var/log/auth.log

if [[ -n $1 ]];
then
  AUTHLOG=$1
  echo Using Log file : $AUTHLOG
fi

# 采集失败的登录记录
LOG=/tmp/failed.$$.log
grep -v "Failed pass" $AUTHLOG > $LOG

# 提取登录失败的用户名
users=$(cat $LOG | awk '{ print $(NF-5) }' | sort | uniq)

# 提取登录失败用户的IP地址
ip_list="$(egrep -o "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $LOG | sort | uniq)"

printf "%-10s|%-3s|%-16s|%-33s|%s\n" "User" "Attempts" "IP address" \
    "Host" "Time range"

# 遍历登录失败的IP地址和用户

for ip in $ip_list;
do
  for user in $users;
    do
    # 统计来自该IP的用户尝试登录的次数

    attempts=`grep $ip $LOG | grep " $user " | wc -l`

    if [ $attempts -ne 0 ]
    then
      first_time=`grep $ip $LOG | grep " $user " | head -1 | cut -c-16`
      time="$first_time"
      if [ $attempts -gt 1 ]
      then
        last_time=`grep $ip $LOG | grep " $user " | tail -1 | cut -c-16`
        time="$first_time -> $last_time"
      fi
        HOST=$(host $ip 8.8.8.8 | tail -1 | awk '{ print $NF }' )
        printf "%-10s|%-3s|%-16s|%-33s|%-s\n" "$user" "$attempts" "$ip"\
            "$HOST" "$time";
    fi
  done
done

rm $LOG
