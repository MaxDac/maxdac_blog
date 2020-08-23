sudo docker run --name mysql -v /home/max/Projets/data/maxdac_blog:/etc/mysql/conf.d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=maxdac-blog --restart unless-stopped -d mysql
sudo docker run --name mysql -v /home/max/Projets/data/maxdac_blog:/etc/mysql/conf.d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=maxdac-blog --restart unless-stopped -d mariadb
