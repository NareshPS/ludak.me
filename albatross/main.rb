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
  "storage/dropbox/#{album}.yml"
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']
Koala.config.api_version = "v2.5"
access_token = "CAACEdEose0cBAEOFgDSSZCNWdcmFQ5Q4OXNTTkd27ZAF9GgAUiJveXZCvaSM0aoVsdTGYzKfAM4IW7OuZCwTBBybYRfi4OZAW9WgVzbCDXBuy0N6oxVrDl3UZCtaDVqZAd39OM3kaDXh69ZBfXYx7vlWbDSXODTUiMyhz7H6HW7d2lufDZCKAf2CmFBLo6Hfc89MyQu6klbftUQZDZD"
user = Koala::Facebook::API.new(access_token)
profile = Albatross::Facebook::Profile.new user, "ludak.me"

albums.each do |album|
  metadata_file = get_metadata_file album
  puts "Processing: #{metadata_file}."
  datastore = Albatross::Datastore.new metadata_file
  profile.album = datastore.get
end
