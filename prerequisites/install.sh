#! /bin/bash

LUDAK_HOME=~/ludak.me

# run in $LUDAK_HOME
cd $LUDAK_HOME

# dropbox ppa
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
set release (lsb_release -sc)
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $release main"
sudo apt-get update

# necessary packages
sudo apt-get install build-essential ruby2.0 ruby2.0-dev apache2 nodejs libmagickwand-dev dropbox python-gpgme

# use ruby 2.0
sudo rm /usr/bin/ruby /usr/bin/irb
sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby
sudo ln -s /usr/bin/irb2.0 /usr/bin/irb

# setup gem 2.0
sudo gem install rubygems-update
sudo update_rubygems

sudo rm /usr/bin/gem
sudo ln -s /usr/bin/gem2.0 /usr/bin/gem

sudo gem install bundler
sudo gem update

# build website
sudo bundle install
jekyll build

# setup webserver
sudo copy $LUDAK_HOME/prerequisites/configuration/ludak.me.conf /etc/apache2/sites-available
sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo ln -s /etc/apache2/sites-available/ludak.me.conf /etc/apache2/sites-enabled/ludak.me.conf

sudo ln -s $LUDAK_HOME/www/_site /var/www/ludak.me

sudo service apache2 start

# return to run directory
cd -
