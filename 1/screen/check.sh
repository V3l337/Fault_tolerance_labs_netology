#!/bin/bash

# Адрес и порт вашего веб-сервера
web_server="127.0.0.1"
web_port="80"

# Проверка доступности порта веб-сервера
nc -z "$web_server" "$web_port"
port_status=$?

# Проверка наличия файла index.html в корне веб-сервера
if [ -f "/var/www/html/index.html" ]; then
    file_exists=0
else
    file_exists=1
fi

# Если порт или файл недоступны, возвращаем ненулевой код возврата
if [ $port_status -ne 0 ] || [ $file_exists -ne 0 ]; then
    exit 1
fi

exit 0
