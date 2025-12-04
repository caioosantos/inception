FROM debian:12-slim

RUN apt-get update \
	&& apt-get upgrade -y --no-install-recommends \
		mariadb-server \
		mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.shs

# Diretório de dados padrão do MariaDB
VOLUME ["/var/lib/mysql"]

CMD []
