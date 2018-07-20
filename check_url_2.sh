#!/bin/bash
# 文件名：check_url_2.sh


web_sz=(
http://www.baidu.com
http://www.souhu.com
http://www.163.com
http://10.0.0.7
)

while true
do
        for ((i=0;i<${#web_sz[*]}; i++))
        do
                echo "${web_sz[$i]}  ---"
                ret_array=($(curl -I --connect-timeout 2 -s ${web_sz[$i]}|head -1))

                        echo "${web_sz[$i]}   ret_val is    ${ret_array[1]}"

                sleep 2

        done

done
