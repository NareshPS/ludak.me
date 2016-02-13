#! /usr/bin/env ruby

require 'azure'

require_relative 'datastore'
require_relative 'storage/azure/blob_storage'
require_relative 'storage/dropbox/utilities'

def get_metadata_file album
  "data/dropbox/#{album}.yml"
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']
DOWNLOAD_DIR = '/tmp'

albums.each do |album|
  metadata_file = get_metadata_file album
  puts "Processing: #{metadata_file}."
  datastore = Albatross::Datastore.new metadata_file
  azure_storage = Albatross::Azure::BlobStorage.new(album.downcase, DOWNLOAD_DIR)
  album_object = datastore.get
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