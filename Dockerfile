FROM php:7.4-fpm-alpine

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装系统依赖及 PHP 扩展
# FastAdmin 核心依赖: pdo_mysql, mysqli, gd, zip, opcache, redis, mbstring, exif, pcntl, bcmath
RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    redis \
    && docker-php-ext-install \
    pdo_mysql \
    mysqli \
    gd \
    zip \
    opcache \
    mbstring \
    exif \
    pcntl \
    bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/cache/apk/*

# 安装 Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# 设置工作目录
WORKDIR /var/www/html

# 权限设置：Alpine 中 www-data 用户 ID 通常为 82
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm"]