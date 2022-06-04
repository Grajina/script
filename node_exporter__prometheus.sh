echo -e '\t- Node_exporter -'

mkdir /home/anika/backup/config_monitoring
cd /home/anika/backup/config_monitoring
#предварительно с гита в отдельной папке скопировать /etc/systemd/system/node_exporter.service
git init;  git remote add origin https://github.com/Grajina/monitoring_config.git; git pull origin main

#в какой директории это делаем? создать спец папку

Предварительно должно быть скачано:
curl -LO https://github.com/prometheus/prometheus/releases/download/v2.34.0/prometheus-2.34.0.linux-amd64.tar.gz
curl -LO https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz


# Распаковка архивов 
tar xzvf node_exporter-*.t*gz
tar xzvf prometheus-*.t*gz

# Добавляем пользователей
useradd --no-create-home --shell /usr/sbin/nologin prometheus
useradd --no-create-home --shell /bin/false node_exporter

# Копируем файлы в /usr/local
cp node_exporter-*.linux-amd64/node_exporter /usr/local/bin
chown node_exporter: /usr/local/bin/node_exporter


#--/home/anika/backup/config_monitoring
cp node_exporter/node_exporter.service /etc/systemd/system/


systemctl daemon-reload
systemctl start node_exporter
#systemctl status node_exporter
systemctl enable node_exporter
echo -e "\n$(ps afx|grep node_exporter)"; echo -e "\n$(ss -ntulp|grep 9100)"
if [ $? == 0 ]
then
 echo -e "\n- Node_exporter OK-";
fi


echo "Enter 'curl localhost:9100/metrics' for check Node_exporter"


echo -e '\n\t- Prometheus -'

#предварительно с гита с отдельной папки скопировать /etc/systemd/system/prometheus.service

mkdir {/etc/,/var/lib/}prometheus
cp -vi prometheus-*.linux-amd64/prom{etheus,tool} /usr/local/bin
cp -rvi prometheus-*.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/
chown -Rv prometheus: /usr/local/bin/prom{etheus,tool} /etc/prometheus/ /var/lib/prometheus/



# Конфиг prometheus с гита
cp prometheus/prometheus.service /etc/systemd/system/
cp prometheus/prometheus.yml /etc/prometheus/prometheus.yml


После этого отдельный скрипт
systemctl daemon-reload
systemctl start prometheus
#systemctl status prometheus
systemctl enable prometheus

echo -e "\n$(ps afx|grep prometheus)"; echo -e "\n$(ss -ntulp|grep 9090)"
if [ $? == 0 ]
then
 echo -e "\n- Prometheus OK-";
fi

echo "Enter 'curl localhost:9090' for check Prometheus"

