#!/bin/bash

# Sai do script se retornar status diferente de zero
set -u pipefail

sleep 2

# Preparar o diretório de dados
WP_CLI=/usr/local/bin/wp
WP_DIR=var/www/html
mkdir -p "${WP_DIR}"
chown -R www-data:www-data "${WP_DIR}"

# Verificar se o banco já foi inicializado
if [ ! -d "${WP_DIR}/wp-config.php" ]; then
	
EOF

fi

# Rodar o mysqld em foreground
exec --user=mysql --datadir=${WP_DIR}
