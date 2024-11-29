# Stage 1: Dependencias
FROM composer:latest as vendor
COPY composer.json composer.lock ./
RUN composer install --no-interaction --no-dev --optimize-autoloader

# Stage 2: Imagen final
FROM php:8.2-apache

# Instalar dependencias en una sola capa
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    default-mysql-client \
    && docker-php-ext-install zip pdo pdo_mysql \
    && a2enmod rewrite headers \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copiar configuración de Apache
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar vendor del stage anterior
COPY --from=vendor /app/vendor/ ./vendor/

# Copiar el resto de archivos del proyecto
COPY . .

# Permisos en una sola capa
RUN chown -R www-data:www-data . \
    && chmod -R 755 .

# Asegurar permisos de directorios
RUN mkdir -p /var/www/html/database \
    && chown -R www-data:www-data /var/www/html/database \
    && chmod -R 777 /var/www/html/database

EXPOSE 80

CMD ["apache2-foreground"]