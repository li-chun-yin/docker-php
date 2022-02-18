FROM ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=
WORKDIR /srv

RUN apt-get update

RUN apt-get install -yq mysql-server

COPY ./php-8.1.3.tar.gz /usr/src/php-8.1.3.tar.gz

RUN apt-get install -yq gcc \
				pkg-config \ 
				libxml2-dev \
				libssl-dev \ 
				libsqlite3-dev \
				zlib1g-dev \
				libcurl4-nss-dev \
				libonig-dev \
				libreadline-dev \
				libsodium-dev \
				libargon2-dev \
				make

RUN cd /usr/src/; \
	tar xfzv php-8.1.3.tar.gz; \
	cd php-8.1.3; \
	./configure \
		--prefix=/usr/local/etc/php \
		--with-config-file-path=/usr/local/etc/php/etc \
		--with-config-file-scan-dir="/usr/local/etc/php/etc/conf.d" \
		--enable-option-checking=fatal \
		--enable-bcmath \
		--enable-ftp \
		--enable-mbstring \
		--enable-mysqlnd \
		--enable-fpm \
		--enable-embed \
		--enable-zts \
		--with-mhash \
		--with-pic \
		--with-password-argon2 \
		--with-sodium=shared \
		--with-pdo-sqlite \
		--with-pdo_mysql \
		--with-sqlite3 \
		--with-curl \
		--with-openssl \
		--with-readline \
		--with-zlib \
		--with-pear \
		--with-libdir \
		--with-fpm-user=www \
		--with-fpm-group=www \
	; \
	make -j "$(nproc)"; \
	make install; \
	ln -s /usr/local/etc/php/bin/php /usr/local/bin/

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./docker-mysql-init.sql /usr/src/docker-mysql-init.sql

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 3306 33060

CMD ["/docker-entrypoint.sh"]

