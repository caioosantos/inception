FROM debian:12-slim

RUN apt-get update \
	&& apt-get install -y --no-instalar-recommends \
		php8.2-fpm php8.2-mysqli php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip \
		curl mariadb-client ca-certificates \
		su-exec tini \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
	&& chown -R www-data:www-data /var/www/html

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY conf/wordpress.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]
EXPOSE 9000
CMD ["/usr/local/bin/entrypoint.sh"]