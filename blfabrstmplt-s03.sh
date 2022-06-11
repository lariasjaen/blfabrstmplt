#!/bin/bash
date > /tmp/blfabrstmplt-s03.txt
sed -Ei 's/^#?([[:space:]]?)+Port([[:space:]]?22([[:space:]]?)+)+$/Port 2222/' /etc/ssh/sshd_config
semanage port -a -t ssh_port_t -p tcp 2222
firewall-cmd --zone=public --add-port=2222/tcp --permanent
sleep 2
firewall-offline-cmd --reload
systemctl restart sshd
date >> /tmp/blfabrstmplt-s03.txt
