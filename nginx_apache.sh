
#!/bin/bash

echo -e "\t- Nginx -"

#Убрать мешающие службы (в самом начале скрипта)
setenforce 0; systemctl stop firewalld

#Репозиторий с пакетами, где есть nginx:
yum install -y epel-release

#Установка и запуск nginx:
yum install -y nginx; systemctl start nginx

#Не забыть поставить в автозагрузку
systemctl enable nginx


#Создать папку бекап перед началом
#mkdir /home/anika/backup

cd /etc/nginx/; tar cf /home/anika/backup/nginx_config.tar  nginx.conf conf.d/* ; rm -r nginx.conf conf.d/*
git init;  git remote add origin https://github.com/Grajina/nginx_config.git; git pull origin main                                                               

echo "git nginx - ok"

nginx -t

if [ $? == 0 ]
then
 echo -e "\n- Syntaxis OK-"; systemctl restart nginx
fi

#вывести на экран результат

echo -e "\n$(ps afx|grep nginx)"; echo -e "\n$(ss -ntulp|grep 80)"
#systemctl status nginx

echo -e "\t- Apache -"

#Установка и запуск Apache:
yum install -y httpd; systemctl start httpd

#/etc/httpd/conf/httpd.conf
#здесь можно руками настроирть порт Listen 8080 или тоже скачать
#git скачать httpd там  /etc/httpd/conf.d/  всё, что внутри (vh.conf)
#echo "конфиги скачали"

cd /etc/httpd/; tar cf /home/anika/backup/apache_config.tar  conf/* conf.d/*; rm -rf conf conf.d
git init;  git remote add origin https://github.com/Grajina/apache_config.git; git pull origin main                                                               

echo "git apache - ok"

apachectl -t

if [ $? == 0 ]
then
 echo -e "\n- Syntaxis OK-"; systemctl restart httpd
fi

#вывести на экран результат
echo -e "\n$(ps afx|grep httpd)"; echo -e "\n$(ss -ntulp|grep 8080)"
#systemctl status httpd

cd /var/www/; tar cf /home/anika/backup/html.tar *; rm -rf *;
git init;  git remote add origin https://github.com/Grajina/html_for_apache.git; git pull origin main                                                               

echo "git html- ok"

echo "Enter 'curl localhost' for check"
