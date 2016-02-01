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
access_token = "CAACEdEose0cBAAZAxMnX2RgN4iAFMr2MAjmVa70ICQ5N8D6l9miyAYR937s3GQZBwgrXcbqvsWEwPElRZAVA93FNi28rUExlO8uL802YIZCzUm4cxOsWTnNJv8f41A2XOOZBWjEQqPmtw6vVHKzWkqtRR6qteIPjOzDWISFTWw5O1MmgAQI526eZAfu8at8wsU29FWkX9ZAYv4aZCJNGM2Og"
user = Koala::Facebook::API.new(access_token)
profile = Albatross::Facebook::Profile.new user, "ludak.me"

albums.each do |album|
  metadata_file = get_metadata_file album
  puts "Processing: #{metadata_file}."
  datastore = Albatross::Datastore.new metadata_file
  profile.album = datastore.get
end
