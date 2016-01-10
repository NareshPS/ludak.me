#! /bin/bash

# necessary packages
sudo apt-get install build-essential ruby2.0 ruby2.0-dev apache2 nodejs libmagickwand-dev

# use ruby 2.0
sudo rm /usr/bin/ruby
sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby

# update rubygems
sudo gem install rubygems-update
sudo update_rubygems

# use gem 2.0
sudo rm /usr/bin/gem
sudo ln -s /usr/bin/gem2.0 /usr/bin/gem

# manages gems
sudo gem install bundler

# update gems
sudo gem update
