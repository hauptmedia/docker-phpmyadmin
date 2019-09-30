FROM debian:stretch

ENV	DEBIAN_FRONTEND noninteractive
ENV	PHPMYADMIN_VERSION 4.9.1

# install required packges
RUN	apt-get update -qq && \
	apt-get install -y curl apache2 php7.0 php7.0-cli php7.0-mysql php7.0-curl php7.0-mbstring mysql-client && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

# configure apache
RUN	rm -rf /var/www/* && \
	a2enmod rewrite

# redirect apache logs to stderr / stdout
RUN	find /etc/apache2 -type f -exec sed -ri ' \
	s!/var/www/html!/var/www!g; \
	s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
        s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
	' '{}' ';'

RUN	sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 2G/" /etc/php/7.0/apache2/php.ini && \		
	sed -i "s/post_max_size = 8M/post_max_size = 8G/" /etc/php/7.0/apache2/php.ini

RUN 	curl -SL https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -o phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz && \
	tar -xzf phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -C /var/www --strip-components=1 && \
	rm phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz

COPY	docker-entrypoint	/usr/local/sbin/docker-entrypoint

EXPOSE 80

ENTRYPOINT ["/usr/local/sbin/docker-entrypoint"]

VOLUME ["/var/log/apache2"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
