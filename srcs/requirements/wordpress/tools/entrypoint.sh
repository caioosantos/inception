#!/bin/bash

# Sai do script se retornar status diferente de zero
set -e

sleep 2

# Preparar o diretório de dados
WP_CLI=/usr/local/bin/wp
WP_DIR=/var/www/html
mkdir -p "${WP_DIR}"
chown -R www-data:www-data "${WP_DIR}"

# Verificar se o banco já foi inicializado
if [ ! -f "${WP_DIR}/wp-config.php" ]; then
	# Baixar WP-CLI
	if [ ! -x "${WP_CLI}" ]; then
		curl -sSL -o ${WP_CLI} https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
		chmod +x ${WP_CLI}
	fi

	# Download do WordPress
	if [ ! -f "${WP_DIR}/wp-load.php" ]; then
		${WP_CLI} core download --allow-root
	fi


	# Criar configuração do WordPress
	${WP_CLI} config create \
		--dbname="${DB_DATABASE}" \
		--dbuser="${DB_USER}" \
		--dbpass="${DB_PASSWORD}" \
		--dbhost="${DB_HOST}" \
		--allow-root

	# Instalar WordPress com usuário admin
	${WP_CLI} core install \
		--url="${WP_URL}" \
		--title="Inception" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	# Criar usuário adicional se as variáveis estiverem definidas
	if [ -n "${WP_USER:-}" ] && [ -n "${WP_USER_PASSWORD:-}" ] && [ -n "${WP_USER_EMAIL:-}" ]; then
		${WP_CLI} user create \
			"${WP_USER}" \
			"${WP_USER_EMAIL}" \
			--user_pass="${WP_USER_PASSWORD}" \
			--path="${WP_DIR}" \
			--allow-root
	fi
fi

# Rodar o mysqld em foreground
exec /usr/sbin/php-fpm8.2 -F
