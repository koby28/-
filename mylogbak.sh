#!/bin/bash
# 文件名：mylogbak.sh
#备份文件并且上传到FTP服务器

backdir=mylog
date=`date +%F`
cd /var

tar zcf ${backdir}_${date}.tar.gz ${backdir}

sleep 1

ftp -n <<- EOF
open 192.168.10.250 #远程FTP服务器IP地址
user aaa bbb
put mylog_*.tar.gz
bye
EOF

rm -rf mylog_*.tar.gz 

#添加crontab
crontab -l
00 05 * * * /bin/bash /root/mylogbak.sh
