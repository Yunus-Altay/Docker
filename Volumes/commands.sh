#########Named volumes#########
# list the docker volumes
docker volume ls
# create a volume named "cw-vol"
docker volume create cw-vol
# list the existing volumes again
docker volume ls
# inspect the created volume
docker inspect cw-vol
# check the volume on the host file system
sudo ls -al  /var/lib/docker/volumes/
# as seen, the volume is empty 
sudo ls -al  /var/lib/docker/volumes/cw-vol/_data
# mount the volume into a container
docker run --rm -it --name clarus -v cw-vol:/cw alpine ash
# create a file in the mount point location
cd cw && echo "This file is created in the container Clarus" > i-will-persist.txt
# check whether the file is also created on the host file system
exit
sudo ls -al  /var/lib/docker/volumes/cw-vol/_data
# check the file itself
sudo cat /var/lib/docker/volumes/cw-vol/_data/i-will-persist.txt
# remove the container
docker container ls
docker container rm -f clarus
# check whether the volume data persists
sudo cat /var/lib/docker/volumes/cw-vol/_data/i-will-persist.txt
# mount the same volume into a another container
docker run --rm -it --name clarus1st -v cw-vol:/cw alpine ash
# check the mount point directory
cd /cw && ls
# see the same volume is mounted and the data persists
cat i-will-persist.txt
exit
# remove the container
docker container ls
docker container rm clarus1st
# delete the volume
docker volume ls
docker volume rm cw-vol


#########Host volumes#########
# create a directory to be used as a host volume
mkdir web_volume && cd web_volume
# create a html file to publish
echo "<h1>Welcome to my WEBPAGE</h1>" > index.html 
# mount the host volume into a nginx container
docker run  -d --name clarus2nd -p 80:80 -v /home/ec2-user/web_volume:/usr/share/nginx/html nginx
# check the webpage
http://<public-ip>:80 
# make a change in the html file
echo "<h1>I love DevOps</h1>" >> index.html
# check the webpage again
docker stop clarus2nd
# the volume is removed because of the '--rm' flag
# list current containers
docker ps -a


#########Remove unused volumes#########
# list volumes
docker volume ls
# remove unused local volumes
docker volume prune
# list volumes again
docker volume ls