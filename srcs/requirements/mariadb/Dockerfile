# imagem base
FROM debian:12-slim

# RUN atualizar, instalar
RUN apt-get update \
	&& apt-get install -y \
		mariadb-server \
		mariadb-client \
		tini \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld

# copiar o código .sh
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY conf/address.conf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /usr/local/bin/entrypoint.sh

# Diretório de dados padrão do MariaDB
VOLUME ["/var/lib/mysql"]

# tini como PID 1 e entrypoint que prepara/inicia o banco
ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh" ]

EXPOSE 3306

# comando default que o entrypoint irá executar (pode ser sobrescrito)
CMD ["/usr/local/bin/entrypoint.sh"]
