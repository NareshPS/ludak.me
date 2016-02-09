#! /usr/bin/env ruby

require 'koala'
require_relative 'datastore'
require_relative 'ludak.me.facebook'
require_relative 'common/throw_if'
require_relative 'facebook/constants'
require_relative 'facebook/profile'

=begin
  Entry point
=end

def get_metadata_file album
  Albatross::ThrowIf.is_nil? album, "album"
  "_data/#{album}.yml"
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Ecuador']
Koala.config.api_version = "v2.5"
access_token = "CAACEdEose0cBADsFgWC7NHKb5vkFIDxLIroh6ZCtHpOFmRDz6HkaK3oZAAvZBD2h63COb4SjBboBxcZAg6z6VBHCJ4M9Y65WWWI4S2xOjlC5lUhQXv8f0Nu9ZAfx57pz458Xfssvh25PZBHHcJjA1GG2Xlsj7ywOZA8GUAzkFQElTxnm6529fZC0OcfqEtgZASOkXVDJbwCRWyQZDZD"
user = Koala::Facebook::API.new(access_token)
profile = Albatross::Facebook::Profile.new user, "ludak.me"

albums.each do |album|
  metadata_file = get_metadata_file album
  puts "Processing: #{metadata_file}."
  datastore = Albatross::Datastore.new metadata_file
  profile.album = datastore.get
end
