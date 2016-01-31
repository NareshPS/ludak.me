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
  "/home/ludak/ludak.me/storage/dropbox/#{album}.yml"
end

albums = ['Barcelona']
Koala.config.api_version = "v2.5"
object_id = 10153209001115636
access_token = "CAACEdEose0cBALLa5wkwqJnkNsh5Iuq4ZByX3W0ewN5TqCgw8G5V8ZBPfmwsHjPGzxB5q8ZCvfvOCYk13ktNoEw3m3G0sda5P108EUQEwZCeRkGJMM7gpvULMONZA2Ek2FnETdCQNgGSQN5POvcbM8PstP71U50b1UfINpeSIOdQVH0bXPvPAROWKv6gINRZCRiaV0ZCyJZBlgZDZD"
user = Koala::Facebook::API.new(access_token)
profile = Albatross::Facebook::Profile.new user, "ludak.me"

albums.each do |album|
  datastore = Albatross::Datastore.new get_metadata_file album
  profile.album = datastore.get
end
