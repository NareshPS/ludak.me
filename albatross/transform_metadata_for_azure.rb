#! /usr/bin/env ruby

require 'azure'
require 'require_all'

require_rel 'metadata'
require_rel 'storage'

def get_metadata(store, album)
  "data/#{store}/#{album}.yml"
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']

metadata_store = Albatross::Metadata::Store.new
albums.each do |album|
  dropbox_metadata_file = get_metadata('dropbox', album)
  azure_metadata_file = get_metadata('azure', album)

  puts "Source: #{dropbox_metadata_file}."
  puts "Destination: #{azure_metadata_file}."

  album_object = metadata_store.load(dropbox_metadata_file)
  album_object.each do |image_set|
    image_url = image_set.first.source
    image_filename = Albatross::Dropbox::Utilities.url_to_filename(image_url)
    image_set.first.source = Albatross::Azure::Utilities.get_blob_url('ludakme', album.downcase, image_filename)
  end

  metadata_store.store(album_object, azure_metadata_file)
end
