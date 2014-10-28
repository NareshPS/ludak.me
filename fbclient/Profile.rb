require 'koala'

require_relative './Album'
require_relative './Image'
require_relative './Photo'

class Profile
  attr_reader :id

  # defines constants
  @@Albums = "albums"
  @@AlbumFieldsPhotos = "photos"
  @@Caption = "caption"
  @@Data = "data"
  @@Description = "description"
  @@Height = "height"
  @@Id = "id"
  @@Images = "images"
  @@Me = "me"
  @@MeFieldsAlbums = "/me?fields=albums{name,description}"
  @@Name = "name"
  @@Photos = "photos"
  @@Source = "source"
  @@Width = "width"

  def initialize(access_token)
    @access_token = access_token
    @user ||= Koala::Facebook::API.new(access_token)
    unravel()
  end

  def unravel()
    @basic_graph ||= @user.get_object(@@Me)
    @id ||= @basic_graph ['id']
  end

  def albums(album_list = [])
    @albums_graph_object ||= @user.get_object(@@MeFieldsAlbums)

    albums = @albums_graph_object[@@Albums][@@Data].map do |album_graph_object|
      album = Album.new album_graph_object[@@Id], album_graph_object[@@Name], album_graph_object[@@Description].to_s.gsub(/@\[[0-9]+:[0-9]+:([^\]]+)\]/, '\1')
    end

    albums.delete_if do |album|
      true if not album_list.include? album.name
    end
  end

  def photos(album_list)
    albums = Array.new
    album_list.each do |album|
      photos_graph_object = @user.get_connections("#{album.id}", @@AlbumFieldsPhotos)
      while photos_graph_object
        photos_graph_object.each do |photo_graph_object|
          photo = Photo.new(photo_graph_object[@@Id], photo_graph_object[@@Name])
          photo_graph_object[@@Images].each do |image_graph_object|
            image = Image.new(image_graph_object[@@Source], image_graph_object[@@Width], image_graph_object[@@Height])
            photo.push(image)
          end
          album.push(photo)
        end
        photos_graph_object = photos_graph_object.next_page
      end
      albums.push(album)
    end
  end

  def to_s()
    return "|Id: #{@id}|"
  end

  private :unravel
end
