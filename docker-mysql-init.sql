CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* to 'root'@'%' WITH GRANT OPTION;
DELETE FROM mysql.user WHERE user='root' AND host='localhost';
FLUSH PRIVILEGES;
