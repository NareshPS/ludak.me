#! /usr/bin/env ruby

require 'azure'
require 'mini_magick'
require 'require_all'

require_rel 'common'
require_rel 'metadata'
require_rel 'storage'

def get_metadata(store, album)
  "data/#{store}/#{album}.yml"
end

def upload_images_to_azure(azure_storage, album, images, existing_blobs)
  images.each do |scale, image|
    image_name = File.basename(image)
    unless existing_blobs.include? image_name
      puts "Uploading #{album.title}/#{image_name} to Azure"
      azure_storage.put(image_name, File.dirname(image))
    end
  end
end

def populate_azure_image_set(source_image_set, scaled_images, azure_album_object)
  azure_image_set = Albatross::ImageSet.new(source_image_set.caption)
  scaled_images.each do |scale, scaled_image|
    name = File.basename(scaled_image)
    source = Albatross::Azure::Utilities.get_blob_url("ludakme", azure_album_object.title.downcase, name)
    azure_image = Albatross::Image.new(source, scale)
    azure_image_set.push(azure_image)
  end
  azure_album_object.push(azure_image_set)
end

albums = ['MountShasta'] #['Netherlands', 'Barcelona', 'Netherlands', 'Rome', 'Peru', 'Japan', 'Colorado', 'Ecuador']
DOWNLOAD_DIR = '/tmp'
resized_images = Albatross::ResizedImages.new
metadata_store = Albatross::Metadata::Store.new

albums.each do |album|
  dropbox_metadata_file = get_metadata("dropbox", album)
  puts "Processing: #{dropbox_metadata_file}."
  dropbox_album_object = metadata_store.load(dropbox_metadata_file)

  azure_storage = Albatross::Azure::BlobStorage.new(album.downcase, DOWNLOAD_DIR)
  azure_album_object = Albatross::Album.new(dropbox_album_object.title, dropbox_album_object.caption)
  existing_blobs = azure_storage.list

  dropbox_album_object.each do |dropbox_image_set|
    source = dropbox_image_set.first.source
    name = Albatross::Dropbox::Utilities.url_to_filename(source)
    scaled_images = resized_images.generate(name, source, DOWNLOAD_DIR)

    upload_images_to_azure(azure_storage, dropbox_album_object, scaled_images, existing_blobs)
    populate_azure_image_set(dropbox_image_set, scaled_images, azure_album_object)
  end

  azure_metadata_file = get_metadata("azure", album)
  puts "Saving: #{azure_metadata_file}."
  metadata_store.store(azure_album_object, azure_metadata_file)
end
