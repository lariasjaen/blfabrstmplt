#!/bin/bash
date > /tmp/blfabrstmplt-s03.txt
echo Change ssh port >> /tmp/blfabrstmplt-s03.txt
sed -Ei 's/^#?([[:space:]]?)+Port([[:space:]]?22([[:space:]]?)+)+$/Port 2222/' /etc/ssh/sshd_config

echo Change selinux ssh port >> /tmp/blfabrstmplt-s03.txt
semanage port -a -t ssh_port_t -p tcp 2222

echo Add firewall ssh port >> /tmp/blfabrstmplt-s03.txt
systemctl stop firewalld
firewall-offline-cmd --add-port=2222/tcp --permanent

echo Start firewall >> /tmp/blfabrstmplt-s03.txt
systemctl start firewalld

echo Restart ssh >> /tmp/blfabrstmplt-s03.txt
systemctl restart sshd

date >> /tmp/blfabrstmplt-s03.txt
