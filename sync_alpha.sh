#!/bin/bash
######################################################################
####  脚本用来同步正式站数据到预览站
######################################################################
#### 1 同步数据库到alpha数据库
#### 2 同步上传数据到alpha
######################################################################
result="N"
read -p "您确认要使用正式站数据覆盖alpha站点数据（不包括程序数据）？（Y/N）: " result

if [[ $result = 'Y' ]]; then
	echo '正在进行数据库数据同步， 请稍候...';
	mysqldump -h localhost -uroot --password='' online_hthouse > /tmp/tmp_sysnc_hthouse.sql && cat /tmp/tmp_sysnc_hthouse.sql | mysql -h localhost -uroot --password='' --database=''
	echo '初始化root登陆密码为:htc@123456, 支付密码为：123456';
	echo 'update member_info set password="", pay_password="" where id=1' | mysql -h localhost -uroot --password='' --database=''
	echo '正在进行上传文件同步...';
	cp -Rf /opt/web/data/online_hthouse/upload/* /opt/web/data/hthouse/upload
	echo '预览站数据同步成功， 此时数据同正式站数据保持一致';
else
	echo '请求已否定， 脚本运行结束';
fi

