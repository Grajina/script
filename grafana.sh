#Отдельный скрипт графана
echo -e '\n\t- Grafana -'


cd /home/anika/backup/config_monitoring
cp grafana/grafana.repo /etc/yum.repos.d/

#Установка

yum install -y grafana

# Запуск
systemctl daemon-reload
systemctl start grafana-server
systemctl status grafana-server


echo -e "\n$(ps afx|grep grafana)"; echo -e "\n$(ss -ntulp|grep 3000)"
if [ $? == 0 ]
then
 echo -e "\n- Grafana OK-";
fi

echo "Enter 'curl localhost:3000' for check Grafana"
echo "log/pass - admin/admin"


echo "Далее настройка из браузера"
