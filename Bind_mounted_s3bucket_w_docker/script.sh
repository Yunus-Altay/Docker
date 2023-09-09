# set -x
sudo apt-get update -y
sudo apt-get install awscli -y
sudo apt-get install s3fs -y
mkdir /home/ubuntu/bucket
cd $HOME/bucket
touch test1.txt test2.txt test3.txt
aws configure
aws s3 sync /home/ubuntu/bucket s3://<your_bucket_name> # --> See, it worked seamlessly
# aws s3 sync /home/ubuntu/bucket s3://simaox-s3-volume-bucket

# Created the credential file for s3fs, s3fs supports a custom passwd file
echo "<access_key_ID>:<secret-access-key" > ${HOME}/.passwd-s3fs
# echo "AKIABJGFNKBLO955787A:kgsm;lhn906854lksgfkls098585vknmdfkgbnk9" > ${HOME}/.passwd-s3fs
chmod 600 ${HOME}/.passwd-s3fs
sudo s3fs <your_bucket_name> /home/ubuntu/bucket  -o passwd_file=$HOME/.passwd-s3fs,nonempty,rw,allow_other,mp_umask=002,uid=$UID,gid=$UID -o url=http://s3.<aws_region>.amazonaws.com,endpoint=<aws_region>,use_path_request_style
# sudo s3fs simaox-s3-volume-bucket /home/ubuntu/bucket  -o passwd_file=$HOME/.passwd-s3fs,nonempty,rw,allow_other,mp_umask=002,uid=1000,gid=1000 -o url=http://s3.us-east-1.amazonaws.com,endpoint=us-east-1,use_path_request_style
mount|grep s3fs # see, s3fs is mounted as a local drive successfully
echo "<your_bucket_name> /home/ubuntu/bucket fuse.s3fs _netdev,allow_other 0 0" | sudo tee -a /etc/fstab
# echo "simaox-s3-volume-bucket /home/ubuntu/bucket fuse.s3fs _netdev,allow_other 0 0" | sudo tee -a /etc/fstab

# Run the following command to uninstall all conflicting packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Install the Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "<h1>Welcome to my website</h1>" > /home/ubuntu/index.html # Created our own html file
docker run -d -p 80:80 --name test_container -v /home/ubuntu/bucket:/usr/share/nginx/html nginx # Put to test if it works, it worked!!
# Check the bucket folder on local and the s3 bucket on AWS