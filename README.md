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

log/pass  -  admin/admin

Панель пока пустая -  добавляем промифиус

Подключаем источник данных - Prometheus
Колёсико - Data sources - Add data source
Прописываем:
http://localhost:9090
<Save&Test>

Далее.
Можно вручную настроить дашборды, но удобнее взять готовое.
"+" - Import

Чтобы добавить нужный дашборд - надо узнать его номер
по ссылке https://grafana.com/grafana/dashboards/

Вставить номер 1860 (Node Exporter Full) 
По нему графана подтянет конфигурацию Load...

Нажимаем <Import>

Открывается страничка с графиками, которые можно настраивать под себя. (цвет, параметры, ..)

4. База данных. MariaDB
5. ELK

