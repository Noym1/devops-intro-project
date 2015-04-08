#!/bin/bash -eux

apt-get -y install nginx
sed -i -e '0,/root \/usr\/share\/nginx\/html/s//root \/home\/vagrant\/devops-kungfu/' /etc/nginx/sites-available/default


# install git, needed for acquiring webapp source code
apt-get -y install git

# remove old node just in case
apt-get remove --purge node

# application and build process required packages
# add Node.js maintained repositories
curl -sL https://deb.nodesource.com/setup | bash -

# for tests and build
apt-get -y install nodejs
# for phantomjs
apt-get -y install libfontconfig1 fontconfig libfontconfig1-dev libfreetype6-dev

# for sass
apt-get -y install ruby
gem install sass

#for running grunt tasks manually
npm install -g grunt-cli


cd /home/vagrant
mkdir devops-kungfu
# get requirement package
cd /home/vagrant/devops-kungfu
wget https://raw.githubusercontent.com/chef/devops-kungfu/master/package.json

# install some packeges missing in the official repo
npm install lru-cache sigmund
npm install accepts batch
npm install qunitjs

# install the rest of the requirements. This takes a while
npm install

# reset permissions
chown vagrant -R /home/vagrant

# reload nginx to serve from the directory
service nginx reload

echo 'Environment is ready, you should fork and clone the repo now.'