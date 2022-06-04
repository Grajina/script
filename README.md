---
yum install mc
yum install git
добавить папку backup
setenforce 0
systemctl stop firewall.service
---

1. Web-Server

Запуск скрипта nginx_apache.sh  чтобы запустить веб-сервер
> bash nginx_apache.sh

проверить работу
> curl localhost


2. Мониторинг

A). Запуск скрипта node_exporter__prometheus.sh 
> node_exporter__prometheus.sh 

Поднимается служба node_exporter - собирает метрики
Поднимается служба prometheus - показывает графики по собраным метрикам

Посмотреть какие метрики собираются
curl localhost:9100/metrics  

Их можно скопировать и вставить их в ip:9090  - увидим график
например - promhttp_metric_handler_requests_total{code="200"}

Б). Запуск grafana.sh
> bash grafana.sh
поднимает графический интерфейс с более удобной визуализацией

зайти в графану - ip:3000

>log/pass  -  admin/admin

Панель пока пустая -  добавляем промифиус

Подключаем источник данных - Prometheus
Колёсико - Data sources - Add data source
Прописываем:
>http://localhost:9090
<Save&Test>

Далее.
Можно вручную настроить дашборды, но удобнее взять готовое.
"+" - Import

Чтобы добавить нужный дашборд - надо узнать его номер
по ссылке https://grafana.com/grafana/dashboards/

Вставить номер 1860 (Node Exporter Full) 
По нему графана подтянет конфигурацию Load...

Нажимаем Import

Открывается страничка с графиками, которые можно настраивать под себя. (цвет, параметры, ..)

4. Настройка MariaDB

Запуск скрипта mysql.sh

А) Настройки Мастера
cat >  /etc/my.cnf.d/server.cnf

[mysqld]
server_id=1
log-basename=master
log-bin
binlog-format=MIXED

(Без log-bin на команду SHOW MASTER STATUS; выводило Empty set)

systemctl restart mariadb.service

заходим в MariaDB и создаем пользователя для реплики:
> mysql -u root -p'testpass1'
> CREATE USER repl@'%' IDENTIFIED BY 'oTUSlave#2020';

Проверяем, что пользователь создался:
> SELECT User, Host FROM mysql.user;

Выдаем права на репликацию:
> GRANT REPLICATION SLAVE ON *.* TO repl@'%';


>SHOW MASTER STATUS;

-
Накатываем дамп:
(должен быть скачан скриптом mysql.sh)

>mysql -u root -p'testpass1' < dump.sql

-


>SHOW MASTER STATUS;




Б) На Slave переназначаем Мастера. 

> stop slave;

значения из верхней команды
> CHANGE MASTER TO MASTER_HOST='192.168.0.22', MASTER_USER='repl', MASTER_PASSWORD='oTUSlave#2020', MASTER_LOG_FILE='mariadb-bin.000002', MASTER_LOG_POS=245;

> start slave;


Проверяем 
>show slave status\G



В) поменяем что-то  на мастере, чтобы посмотреть, что это изменилось на Slave

либо drop 
либо 
>create database BD_kotik;
>show databases;
>create table BD_kotik.TBL_meow (id int);
>insert into BD_kotik.TBL_meow values (25),(12),(96);

посмотрим на Slave , что все изменения подтянулись
>show databases;
>select * from BD_kotik.TBL_meow;


5. ELK

