FROM centos
RUN echo 'Installing httpd & VIM'
RUN /usr/bin/yum install -y httpd vim sudo 
RUN echo 'Installing Mariadb'
RUN yum install mariadb-server -y
RUN sudo systemctl start mariadb.service 
ENV zabbix_db_pass="zabbix123"
RUN mysql -uroot <<MYSQL_SCRIPT \
    create database zabbix character set utf8 collate utf8_bin; \
    grant all privileges on zabbix.* to zabbix@'localhost' identified by '${zabbix_db_pass}'; \
    FLUSH PRIVILEGES; \
MYSQL_SCRIPT
RUN yum install -y https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
RUN yum install zabbix-server-mysql zabbix-agent zabbix-get
RUN yum-config-manager --enable zabbix-frontend
RUN yum -y install centos-release-scl
RUN yum -y install zabbix-web-mysql-scl zabbix-apache-conf-scl
RUN zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix123
RUN sed -i 's/DBName=.*/DBName=zabbix/g' /etc/zabbix/zabbix_server.conf
RUN sed -i 's/#DBName=.*/DBName=zabbix/g' /etc/zabbix/zabbix_server.conf
RUN sed -i 's/DBUser=.*/DBUser=zabbix/g' /etc/zabbix/zabbix_server.conf
RUN sed -i 's/#DBUser=.*/DBUser=zabbix/g' /etc/zabbix/zabbix_server.conf
RUN sed -i 's/DBPassword=.*/DBPassword=zabbix123/g' /etc/zabbix/zabbix_server.conf
RUN sed -i 's/#DBPassword=.*/DBPassword=zabbix123/g' /etc/zabbix/zabbix_server.conf
RUN sudo systemctl restart zabbix-server zabbix-agent httpd rh-php72-php-fpm
RUN sudo systemctl enable zabbix-server zabbix-agent httpd rh-php72-php-fpm

