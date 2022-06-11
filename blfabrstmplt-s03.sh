#!/bin/bash
sed -Ei 's/^#?([[:space:]]?)+Port([[:space:]]?22([[:space:]]?)+)+$/Port 2222/' /etc/ssh/sshd_config
semanage port -a -t ssh_port_t -p tcp 2222
firewall-cmd --zone=public --add-port=2222/tcp --permanent
firewall-cmd --reload
systemctl restart sshd
