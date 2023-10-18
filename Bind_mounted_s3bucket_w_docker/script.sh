# Update the packages 
sudo apt-get update -y
# Install aws-cli
sudo apt-get install awscli -y
# Install s3fs
sudo apt-get install s3fs -y
# Let's create a folder for S3 bucket
mkdir /home/ubuntu/bucket
cd $HOME/bucket
touch test1.txt test2.txt test3.txt
# Configure aws-cli
aws configure
# Synchronize the local folder with the S3 bucket
aws s3 sync /home/ubuntu/bucket s3://<your_bucket_name> 

# Create the credential file for s3fs, s3fs supports a custom password file
echo "<access_key_ID>:<secret-access-key" > ${HOME}/.passwd-s3fs
# Set the required permissions for the key file
chmod 600 ${HOME}/.passwd-s3fs
sudo s3fs <your_bucket_name> /home/ubuntu/bucket  -o passwd_file=$HOME/.passwd-s3fs,nonempty,rw,allow_other,mp_umask=002,uid=$UID,gid=$UID -o url=http://s3.<aws_region>.amazonaws.com,endpoint=<aws_region>,use_path_request_style
# You may change the digital values of the user id, group id and umask according to your configuration
mount|grep s3fs 
# S3fs is mounted as a local drive successfully
# Add the entry in fstab to persist the changes after the reboot
echo "<your_bucket_name> /home/ubuntu/bucket fuse.s3fs _netdev,allow_other 0 0" | sudo tee -a /etc/fstab

# Uninstall all conflicting packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Install the Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Verify that Docker is installed
docker --version
# Created our own html file 
echo "<h1>Welcome to my website</h1>" > /home/ubuntu/bucket/index.html 
sudo usermod -aG docker $USER
newgrp docker
# Docker commands will run now with the current user
# Let's put it to the test to see if it works
docker run -d -p 80:80 --name test_container -v /home/ubuntu/bucket:/usr/share/nginx/html nginx 
# Check the URL <instance-publicIP>
# Check the bucket folder on local and the s3 bucket on AWS