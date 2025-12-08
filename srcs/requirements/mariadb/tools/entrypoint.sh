#!/bin/bash

# Sai do script se retornar status diferente de zero
set -u pipefail

# Preparar o diretório de dados
DB_DIR="/var/lib/mysql"
mkdir -p ${DB_DIR}
chown -R mysql:mysql ${DB_DIR}
chmod 700 ${DB_DIR}

# Verificar se o banco já foi inicializado
if [ ! -d "${DB_DIR}/mysql" ]; then
	# Inicializar o MariaDB
	mysql_install_db --user=mysql --datadir=${DB_DIR}

	# Iniciar o MariaDB temporariamente para configuração
	mysqld --user=mysql --datadir=${DB_DIR} --skip_working &
	MYSQL_PID="!$"

	# Aguardar o MariaDB iniciar
	sleep 5

	# Criar banco de dados e usuário
	mysql -uroot <<-EOF
		CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
		CREATE USER IF NOT EXITST '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD};
		GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		FLUSH PRIVILEGES;

EOF
	# Parar o MariaDB temporário
	kill ${MYSQL_PID}
	wait ${MYSQL_PID}
fi

# Rodar o mysqld em foreground
exec --user=mysql --datadir=${DB_DIR}
