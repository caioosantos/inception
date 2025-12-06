# imagem base
FROM debian:12-slim

# RUN atualizar, instalar
RUN apt-get update \
	&& apt-get upgrade -y --no-install-recommends \
		mariadb-server \
		mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

# copiar o código .sh
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY conf/address.conf /etc/mysql/address.conf
RUN chmod +x /usr/local/bin/entrypoint.sh

# Diretório de dados padrão do MariaDB
VOLUME ["/var/lib/mysql"]

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh" ]

CMD []
