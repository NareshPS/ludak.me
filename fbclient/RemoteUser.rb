require 'koala'
require './Album'

class RemoteUser
  attr_reader :id

  # defines constants
  @@Albums = "albums"
  @@AlbumsUri = "/me?fields=albums{name,description}"
  @@Data = "data"
  @@Description = "description"
  @@Id = "id"
  @@Me = "me"
  @@Name = "name"
  @@PhotosUriPostfix = "?fields=photos{id,images}"

  def initialize(access_token)
    @access_token = access_token
    @user ||= Koala::Facebook::API.new(access_token)
    unravel()
  end

  def unravel()
    @basic_info ||= @user.get_object(@@Me)
    @id ||= @basic_info ['id']
  end

  def albums(album_list = [])
    @albums_info_object ||= @user.get_object(@@AlbumsUri)

    albums = @albums_info_object[@@Albums][@@Data].map do |album_info_object|
      album = Album.new album_info_object[@@Id], album_info_object[@@Name], album_info_object[@@Description]
    end

    albums.delete_if do |album|
      true if not album_list.include? album.name
    end
  end

  def photos(album_list)
    @photos_info_object ||= {}
    album_list.each do |album|
      @photos_info_object[album.id] ||= @user.get_object("#{album.id}#{@@PhotosUriPostfix}")
      puts @photos_info_object[album.id]
    end
  end

  def to_s()
    return "Id: #{@id}"
  end

  private :unravel
end
