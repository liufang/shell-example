#!/bin/bash
##############################################
###   脚本创建虚拟服务器(Apache)
##############################################
config_path='/etc/apache2';
host=$1;
## 参数整理
if [ "$1" == '' ];then
	read -p "请输入访问域名:" host;
fi

app_path="/opt/web/$host";

if [ "$2" == '' ];then
	read -p "请输入网站根目录(默认为 $app_path):" app_path;
fi


site_config_file_name="$host.conf";
## 删除原有该网站配置信息
config_file="$config_path/sites-available/$site_config_file_name";
ln_file="$config_path/sites-enabled/$site_config_file_name";
if [ -f $ln_file ]; then
	rm $ln_file;
fi

echo "<VirtualHost *:80>
	ServerName $host
	ServerAdmin i@liufang.org.cn
	DocumentRoot $app_path
</VirtualHost>
" > $config_file;

#做网站链接
ln -s "$config_file" "$ln_file";

#重启服务器生效配置信息
service apache2 reload;

echo "新站点创建成功, 马上访问: http://$host/";
