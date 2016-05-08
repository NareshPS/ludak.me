#! /usr/bin/fish

set LUDAK_HOME ~/ludak.me

# run in $LUDAK_HOME
and cd $LUDAK_HOME

# dropbox ppa
and sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
and set UBUNTU_RELEASE (lsb_release -sc)
and sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $UBUNTU_RELEASE main"
and sudo apt-get update

# necessary packages
and sudo apt-get install build-essential ruby2.0 ruby2.0-dev apache2 nodejs libmagickwand-dev dropbox python-gpgme ruby-rspec-core GraphicsMagick

# use ruby 2.0
and sudo rm /usr/bin/ruby /usr/bin/irb
and sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby
and sudo ln -s /usr/bin/irb2.0 /usr/bin/irb

# setup gem 2.0
and sudo gem install rubygems-update
and sudo update_rubygems
and sudo rm /usr/bin/gem
and sudo ln -s /usr/bin/gem2.0 /usr/bin/gem

and sudo gem install bundler
and sudo gem update

# build website
and sudo bundle install
and jekyll build

# setup webserver
and sudo copy $LUDAK_HOME/prerequisites/configuration/ludak.me.conf /etc/apache2/sites-available
and sudo rm /etc/apache2/sites-enabled/000-default.conf
and sudo ln -s /etc/apache2/sites-available/ludak.me.conf /etc/apache2/sites-enabled/ludak.me.conf
and sudo ln -s $LUDAK_HOME/www/_site /var/www/ludak.me
and sudo service apache2 start

# return to run directory
and cd -
