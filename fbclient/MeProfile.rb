require 'koala'

require './Album'
require './Image'
require './Photo'

class MeProfile
  attr_reader :id

  # defines constants
  @@Albums = "albums"
  @@AlbumsUri = "/me?fields=albums{name,description}"
  @@Caption = "caption"
  @@Data = "data"
  @@Description = "description"
  @@Height = "height"
  @@Id = "id"
  @@Images = "images"
  @@Me = "me"
  @@Name = "name"
  @@Photos = "photos"
  @@PhotosUriPostfix = "?fields=photos{id,images,name}"
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
    @albums_graph_object ||= @user.get_object(@@AlbumsUri)

    albums = @albums_graph_object[@@Albums][@@Data].map do |album_graph_object|
      album = Album.new album_graph_object[@@Id], album_graph_object[@@Name], album_graph_object[@@Description]
    end

    albums.delete_if do |album|
      true if not album_list.include? album.name
    end
  end

  def photos(album_list)
    @photos_graph_object ||= {}
    albums = Array.new
    album_list.each do |album|
      @photos_graph_object[album.id] ||= @user.get_object("#{album.id}#{@@PhotosUriPostfix}")
      @photos_graph_object[album.id][@@Photos][@@Data].each do |photo_graph_object|
        photo = Photo.new(photo_graph_object[@@Id], photo_graph_object[@@Caption])
        photo_graph_object[@@Images].each do |image_graph_object|
          image = Image.new(image_graph_object[@@Source], image_graph_object[@@Width], image_graph_object[@@Height])
          photo.push(image)
          print image
        end
        album.push(photo)
      end
      albums.push(album)
    end
  end

  def to_s()
    return "|Id: #{@id}|"
  end

  private :unravel
end
