FROM debian:jessie

ENV	DEBIAN_FRONTEND noninteractive

# install required packges
RUN	echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections && \
	echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections && \
	echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections && \
	echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections && \
	echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections && \ 
	apt-get update -qq && \
	apt-get install -y apache2 php5 php5-mysql php5-curl mysql-client phpmyadmin && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

# patch phpmyadmin to not use internal pma database
RUN	sed -i 's/!empty(\$dbname)/TRUE/' /etc/phpmyadmin/config.inc.php

# configure apache
RUN	rm -rf /var/www && \
	a2dissite 000-default && \
	a2enmod php5 && \
	a2enmod rewrite

COPY	docker-entrypoint.sh	/usr/local/sbin/docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]

VOLUME ["/var/log/apache2"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
