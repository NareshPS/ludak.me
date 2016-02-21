#! /usr/bin/env ruby

require 'azure'
require 'require_all'

require_rel 'metadata'
require_rel 'storage'

def get_metadata(store, album)
  "data/#{store}/#{album}.yml"
end

def create_azure_album(album)
  album_object.each do |image_set|
    image_url = image_set.first.source
    image_filename = Albatross::Dropbox::Utilities.url_to_filename(image_url)
    image_set.first.source = Albatross::Azure::Utilities.get_blob_url('ludakme', album.downcase, image_filename)
  end
end

albums = ['Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']

metadata_store = Albatross::Metadata::Store.new
albums.each do |album|
  dropbox_metadata_file = get_metadata('dropbox', album)
  azure_metadata_file = get_metadata('azure', album)

  puts "Source: #{dropbox_metadata_file}."
  puts "Destination: #{azure_metadata_file}."

  album_object = metadata_store.load(dropbox_metadata_file)
  azure_album_object = create_azure_album(album_object)
  metadata_store.store(azure_album_object, azure_metadata_file)
end

  metadata_file = get_metadata("dropbox", album)
  puts "Processing: #{metadata_file}."
  metadata_store = Albatross::Metadata::Store.new
  azure_storage = Albatross::Azure::BlobStorage.new(album.downcase, DOWNLOAD_DIR)
  album_object = metadata_store.load(metadata_file)
  source = album_object.first.first.source
  name = Albatross::Dropbox::Utilities.url_to_filename(source)
  scaled_images = resized_images.generate(name, source, DOWNLOAD_DIR)
  scaled_images.each do |scaled_image|
    scaled_image_name = File.basename(scaled_image)
    puts "Uploading #{album_object.title}/#{scaled_image_name} to Azure"
    azure_storage.put(scaled_image_name, DOWNLOAD_DIR)
