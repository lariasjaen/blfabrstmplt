#!/bin/bash
date > /tmp/blfabrstmplt-s03.txt
echo Change sshd port configuration >> /tmp/blfabrstmplt-s03.txt
sed -Ei 's/^#?([[:space:]]?)+Port([[:space:]]?22([[:space:]]?)+)+$/Port 2222 # Modified by automation/' /etc/ssh/sshd_config 2>&1 >>  /tmp/blfabrstmplt-s03.txt

echo Add TCP port 2222 to SELinux >> /tmp/blfabrstmplt-s03.txt
semanage port -a -t ssh_port_t -p tcp 2222 >> /tmp/blfabrstmplt-s03.txt

echo Add firewall ssh port >> /tmp/blfabrstmplt-s03.txt
systemctl stop firewalld >> /tmp/blfabrstmplt-s03.txt
firewall-offline-cmd --add-port=2222/tcp >> /tmp/blfabrstmplt-s03.txt
systemctl start firewalld >> /tmp/blfabrstmplt-s03.txt

echo Restart ssh >> /tmp/blfabrstmplt-s03.txt
systemctl restart sshd >> /tmp/blfabrstmplt-s03.txt

date >> /tmp/blfabrstmplt-s03.txt
