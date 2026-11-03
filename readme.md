针对 FastAdmin（基于 ThinkPHP 框架）的生产级部署，推荐采用 ‌Nginx + PHP-FPM + MySQL + Redis‌ 的四容器架构。这种分离架构能实现动静分离、资源隔离和高可用性。

启动容器‌   docker-compose up -d --build
安装依赖‌：
进入 PHP 容器安装 Composer 依赖并设置权限：

docker exec -it fa_php sh
cd /var/www/html
composer install
# 设置运行时目录权限
chmod -R 777 runtime
chmod -R 777 public/uploads
exit


启动访问：http://localhost:8080