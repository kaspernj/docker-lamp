FROM ubuntu:16.04
MAINTAINER k@spernj.org

# APT configuration
ENV DEBIAN_FRONTEND=noninteractive \
    MYSQL_USER=mysql \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

COPY docker_config/apt_get_source_hetzner.list /etc/apt/sources.list.d/hetzner.list
RUN rm /etc/apt/sources.list

# Install packages
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y openssh-server sudo nano cron

# Configure deploy user
RUN ["/usr/sbin/useradd", "-s", "/bin/bash", "-m", "deploy"]
COPY docker_config/deploy_ssh_config /home/deploy/.ssh/config
RUN chmod 600 /home/deploy/.ssh/config

COPY docker_config/deploy_authorized_keys /home/deploy/.ssh/authorized_keys
RUN chmod 600 /home/deploy/.ssh/authorized_keys

RUN mkdir /var/run/sshd

COPY docker_config/deploy_sudo_access /etc/sudoers.d/90-deploy-user

RUN chown -R deploy:deploy /home/deploy/.ssh

# Install logging
RUN apt-get install -y rsyslog

# Install Apache and PHP
RUN apt-get install -y apache2 libapache2-mod-php php7.0
RUN rm /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /shared/apache2.conf /etc/apache2/sites-enabled/001-lamp.conf
RUN rm /etc/php/7.0/apache2/php.ini
RUN ln -s /shared/php.ini /etc/php/7.0/apache2/php.ini
RUN a2dismod mpm_event
RUN a2enmod mpm_prefork

# Install MySQL
RUN apt-get install -y mysql-server
RUN rm -rf ${MYSQL_DATA_DIR}
RUN apt-get install -y phpmyadmin

# Start SSH
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
