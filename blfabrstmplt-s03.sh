#!/bin/bash
date > /tmp/blfabrstmplt-s03.txt
echo Change ssh port >> /tmp/blfabrstmplt-s03.txt
sed -Ei 's/^#?([[:space:]]?)+Port([[:space:]]?22([[:space:]]?)+)+$/Port 2222/' /etc/ssh/sshd_config
echo Change selinux ssh port >> /tmp/blfabrstmplt-s03.txt
semanage port -a -t ssh_port_t -p tcp 2222
echo Add firewall ssh port >> /tmp/blfabrstmplt-s03.txt
firewall-cmd --zone=public --add-port=2222/tcp --permanent
echo Reload firewall >> /tmp/blfabrstmplt-s03.txt
firewall-offline-cmd --reload
echo Restart ssh >> /tmp/blfabrstmplt-s03.txt
systemctl restart sshd
date >> /tmp/blfabrstmplt-s03.txt
