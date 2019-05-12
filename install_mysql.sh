export DEBIAN_FRONTEND=noninteractive
MYSQL_USER="root"
MYSQL_PASS="123"
MYSQL_ADDRESS="localhost"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASS"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASS"
apt-get install -y mysql-server
/etc/init.d/mysql start
MYSQL_ADDRESS=localhost
result="$(mysql -u$MYSQL_USER -p$MYSQL_PASS -h$MYSQL_ADDRESS -e "DROP USER 'root'@'localhost'; CREATE USER 'root'@'%' IDENTIFIED BY '$MYSQL_PASS'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;" 2>&1)"
echo $result
