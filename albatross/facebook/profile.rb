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
        album = self.album album_object.title

        if album.nil?
          @connection.put_connections(profile, Constants::ALBUMS, {:name => album_object.title, :caption => album_object.caption})
          album = self.album album_object.title
        end

        unless album.nil? or album.size != 0
          album_object.each do |image_set|
            @connection.put_picture(image_set.first.source, {:message => image_set.caption}, album.id)
          end
        end
      end

      def album(name)
        ThrowIf.is_nil? name, "name"
        results = @connection.get_connections(profile, Constants::ALBUMS, {Constants::FIELDS => [Constants::ID, Constants::NAME, Constants::DESCRIPTION]})
        result = results.select {|result| result[Constants::NAME] === name}
        album = nil

        unless result.nil? or result.size == 0
          remote_object = result.first
          results = @connection.get_connections(
                      remote_object[Constants::ID],
                      Constants::PHOTOS,
                      {
                        Constants::FIELDS => [
                          Constants::NAME,
                          Constants::IMAGES
                        ]
                      })
          album = Album.new(name, remote_object[Constants::DESCRIPTION], remote_object[Constants::ID])
          populate_album_from_results(album, results)
        end
        album
      end

      private
      def populate_album_from_results(album, results)
        unless results.nil?
          results.each do |result|
            image_set = ImageSet.new result[Constants::NAME]
            result[Constants::IMAGES].each do |image|
              image_set.push Image.new(image[Constants::SOURCE], image[Constants::WIDTH], image[Constants::HEIGHT])
            end
            album.push image_set
          end
        end
      end
    end
  end
end
