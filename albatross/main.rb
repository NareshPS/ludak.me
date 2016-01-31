#! /usr/bin/env ruby

require 'koala'
require_relative 'facebook/constants'
require_relative 'facebook/profile'

=begin
  Entry point
=end

module Albatross
  Koala.config.api_version = "v2.5"
  access_token = "CAACEdEose0cBABOkuwrBqpwnHbAoqmek9mgyx4YnL3dl5aKLKNSWdEGGSRVRiImExwA1q83E1XGoLwkCZAsYCJ3xaOkZA9CZCaGezIF09140VtrZCoE5ZCRiLNwb1jFwZCqSZAG2xMZBNhRzVN4mokhulZB5XaatZA96MZBsZAvEfGcUBQCpXZCE9jQb5ntCP3kWM7PjFbbuDC12n2sVDxIet7bIK"
  object_id = 10153209001115636
  user = Koala::Facebook::API.new(access_token)
  profile = Facebook::Profile.new user, "ludak.me"
  puts profile.album "Test Album"
  #image = user.get_object("#{object_id}?fields=name,images")
  #album = user.get_connections("ludak.me", "albums")
  #album = user.put_connections("ludak.me", "albums", {:name => "Test Album", :caption => "test caption"})
  #user.put_picture(image['images'][0]['source'], {:message => image['name']}, album[Facebook::Constants::ID])
  #user.put_picture()
  #profile = Profile.new user
end
