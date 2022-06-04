# Запускаем сервис elasticsearch
systemctl start elasticsearch.service
systemctl enable elasticsearch.service

#Скачать настройки для кибаны
cd /etc/kibana/; tar cf /home/anika/backup/kibana_config.tar  kibana.yml ; rm -r kibana.yml 
git init;  git remote add origin https://github.com/Grajina/kibana.git; git pull origin main  

# Запускаем сервис kibana
systemctl start kibana.service
systemctl enable kibana.service

#Скачать настройки для логстеша
cd /etc/logstash/; tar cf /home/anika/backup/logstash_config.tar  logstash.yml conf.d/*; rm -r logstash.yml conf.d/*
git init; git remote add origin https://github.com/Grajina/logstash.git; git pull origin main

# Запускаем сервис logstash
systemctl start logstash.service
systemctl enable logstash.service

# Запускаем сервис filebeat
cd /etc/filebeat/; tar cf /home/anika/backup/filebeat_config.tar  filebeat.yml ; rm -r filebeat.yml
git init; git remote add origin https://github.com/Grajina/filebeat.git; git pull origin main

# Запускаем сервис filebeat
systemctl start filebeat.service
systemctl enable filebeat.service
