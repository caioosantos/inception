#!/bin/bash

# Sai do script se retornar status diferente de zero
set -e

# Verificar se o banco já foi inicializado
if [ ! -d "/var/lib/mysql/mysql" ]; then
	# Inicializar o MariaDB
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	# Iniciar o MariaDB temporariamente para configuração
	mysqld --user=mysql --datadir=/var/lib/mysql &
	MYSQL_PID="$!"

	# Aguardar o MariaDB iniciar
	sleep 2

	# Criar banco de dados e usuário
	mysql -uroot <<-EOF
		CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		FLUSH PRIVILEGES;
	EOF

	# Parar o MariaDB temporário
	kill ${MYSQL_PID}
	wait ${MYSQL_PID}
fi

# Rodar o mysqld em foreground
exec mysqld --user=mysql --datadir=/var/lib/mysql
