#!/bin/bash
########################################################################
#################  线上程序从alpha导入程序
########################################################################
read -p "您确认要同步alpha站点程序到正式站？（Y/N）: " result

if [[ $result = 'Y' ]]; then
	svn export /opt/web/app/hthosue/trunk /opt/web/app/hthosue/online --force
	echo 'alpha站点程序已经成功同步到正式站点， 如果alpha站点有数据库更改，请尽快更改数据库以便数据库正常运行';
else
	echo '请求已否定， 脚本运行结束';
fi
