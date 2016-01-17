#! /bin/bash

LUDAK_HOME=~/ludak.me

# dropbox ppa
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
set release (lsb_release -sc)
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $release main"
sudo apt-get update

# necessary packages
sudo apt-get install build-essential ruby2.0 ruby2.0-dev apache2 nodejs libmagickwand-dev dropbox python-gpgme

# use ruby 2.0
sudo rm /usr/bin/ruby
sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby

# setup gem 2.0
sudo gem install rubygems-update
sudo update_rubygems

sudo rm /usr/bin/gem
sudo ln -s /usr/bin/gem2.0 /usr/bin/gem

sudo gem install bundler
sudo gem update

# build website
cd ${LUDAK_HOME} && jekyll build && cd -

# setup webserver
sudo copy configuration/ludak.me.conf /etc/apache2/sites-available
sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo ln -s /etc/apache2/sites-available/ludak.me.conf /etc/apache2/sites-enabled/ludak.me.conf

sudo ln -s ~/ludak.me/_site /var/www/ludak.me

sudo service apache2 start
