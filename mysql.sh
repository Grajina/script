*** MySql***

#Запуск БД
systemctl start mariadb.service
systemctl enable mariadb.service

Проверяем, что поднялось:
#systemctl status mariadb.service
echo -e "\n$(ps afx|grep maria)"; echo -e "\n$(ss -ntulp|grep 3306)"
if [ $? == 0 ]
then
 echo -e "\n- Mysql OK-"; systemctl restart httpd
fi

mkdir /home/anika/dumps; cd /home/anika/dumps
git init; git pull https://github.com/Grajina/dump.git

echo "Дамп со Slave  в home/anika/dumps "

mysql_secure_installation
