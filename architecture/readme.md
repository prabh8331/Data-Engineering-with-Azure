# Architecute I used for this course 

I have linux server on which docker is installed, I like to host my all such application there which are continusally running and I don't want my desktop to eat up lot of ram and space due to such applitions

```bash
# create one docker network
sudo docker network create --driver bridge data_eng_network

# go to mysql folder where docker-compose file is saved
sudo docker compose up -d

# access mysql
sudo docker exec -it mysql_container mysql -u admin -p
# basic commands
show databases;
use mydatabase;


```