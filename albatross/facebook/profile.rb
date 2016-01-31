require_relative 'constants'
require_relative '../common/album'
require_relative '../common/throw_if'
require_relative '../common/image'
require_relative '../common/image_set'

=begin
  Provides functionality to interact with Facebook using Koala.
=end
module Albatross
  module Facebook
    class Profile
      attr_reader :connection, :profile

      def initialize(connection, profile)
        ThrowIf.is_nil? connection, "connection"
        ThrowIf.is_nil? profile, "profile"
        @connection = connection
        @profile = profile
      end

      def album=(album_object)
        ThrowIf.is_nil? album_object, "album_object"
        remote_album = self.album album_object.title

        if remote_album.nil?
          remote_album = @connection.put_connections(profile, Constants::ALBUMS, {:name => album_object.title, :caption => album_object.caption})
        end

        unless remote_album.nil?
          album_object.image_sets.each do |image_set|
            image = image_set.images[0]
            @connection.put_picture(image.source, {:message => image_set.caption}, remote_album[Facebook::Constants::ID])
          end
        end
      end

      def album(name)
        ThrowIf.is_nil? name, "name"
        results = @connection.get_connections(profile, Constants::ALBUMS, {Constants::FIELDS => [Constants::ID, Constants::NAME, Constants::DESCRIPTION]})
        result = results.select {|result| result[Constants::NAME] === name}

        unless result.nil?
          album_object = result.first
          results = @connection.get_connections(
                      album_object[Constants::ID],
                      Constants::PHOTOS,
                      {
                        Constants::FIELDS => [
                          Constants::NAME,
                          Constants::IMAGES
                        ]
                      })
          Album.new(album_object[Constants::NAME], image_sets_from_results(results), album_object[Constants::DESCRIPTION])
        end
      end

      private
      def image_sets_from_results(results)
        image_sets = Array.new
        unless results.nil?
          results.each do |result|
            images = Array.new
            result[Constants::IMAGES].each do |image|
              images.push(Image.new(image[Constants::SOURCE], image[Constants::WIDTH], image[Constants::HEIGHT]))
            end
            image_sets.push(ImageSet.new(images, result[Constants::NAME]))
          end
        end
        image_sets
      end
    end
  end
end

=begin

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
=end
