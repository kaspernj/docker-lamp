#!/bin/sh

/usr/sbin/rsyslogd
apache2ctl graceful
/usr/sbin/sshd -D
mysql -u root -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '' WITH GRANT OPTION;"
