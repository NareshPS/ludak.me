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
and sudo apt-get install build-essential ruby ruby-dev apache2 nodejs libmagickwand-dev dropbox python-gpgme ruby-rspec-core graphicsmagick

# setup gems
and sudo gem install rubygems-update
and sudo update_rubygems
and sudo gem install bundler
and gem update

# build website
and cd $LUDAK_HOME/www
and sudo gem install rmagick
and bundle install
and jekyll build
and cd -

# setup webserver
and sudo cp $LUDAK_HOME/prerequisites/configuration/ludak.me.conf /etc/apache2/sites-available
and sudo rm /etc/apache2/sites-enabled/000-default.conf
and sudo ln -s /etc/apache2/sites-available/ludak.me.conf /etc/apache2/sites-enabled/ludak.me.conf
and sudo ln -s $LUDAK_HOME/www/_site /var/www/ludak.me
and sudo service apache2 start

# return to run directory
and cd -
