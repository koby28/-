#!/bin/bash
#批量检查多个网站地址是否正常
# File Name: check_url.sh

web_array=(
http://blog.oldboyedu.com
http://blog.etiantian.org
http://oldboy.blog.51cto.com
http://10.0.0.7
)

while true
do
    for (( i=0;i<${#web_array[*]};i++ ))
    do
        wget -T 10 --tries=2 --spider ${web_array[$i]} >/dev/null 2>&1
        if [ $? -eq 0 ]
        then
            echo "${web_array[$i]} is ok"
        else
            echo "${web_array[$i]} is bad"
        fi
        sleep 3
    done
done

