#! /usr/bin/env ruby

require 'azure'
require 'require_all'

require_rel 'metadata'
require_rel 'storage'

def get_metadata(store, album)
  "data/#{store}/#{album}.yml"
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']
DOWNLOAD_DIR = '/tmp'

albums.each do |album|
  metadata_file = get_metadata("dropbox", album)
  puts "Processing: #{metadata_file}."
  metadata_store = Albatross::Metadata::Store.new
  azure_storage = Albatross::Azure::BlobStorage.new(album.downcase, DOWNLOAD_DIR)
  album_object = metadata_store.load(metadata_file)
  existing_blobs = azure_storage.list
  album_object.each do |image_set|
    image_url = image_set.first.source
    image_filename = Albatross::Dropbox::Utilities.url_to_filename(image_url)
    unless existing_blobs.include? image_filename
      puts "Uploading #{album_object.title}/#{image_filename} to Azure"
      azure_storage.put image_filename, image_url
    end
  end
end
