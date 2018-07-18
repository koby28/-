#!/bin/bash
#configure yum scripts

#mount cdrom
umount /yum
mount /dev/cdrom /yum


#configure yum 
rm -rf /etc/yum.repos.d/*
touch /etc/yum.repos.d/yum.repo
cat > /etc/yum.repos.d/yum.repo << EOF
[Centos7]
name=server
baseurl=file:///yum
gpgcheck=0
enabled=1
EOF
