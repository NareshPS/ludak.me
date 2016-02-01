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
          puts "Album: #{album} not found. Create one!"
          @connection.put_connections(profile, Constants::ALBUMS, {:name => album_object.title, :caption => album_object.caption})
          album = self.album album_object.title
          puts "Created album: #{album}"
        end

        unless album.nil?
          album_object_slice = album_object.slice(album.size, album_object.size - album.size)
          puts album_object_slice.size
          unless album_object_slice.nil?
            puts "Images remaining to upload: #{album_object_slice.size}"
            album_object_slice.each do |image_set|
              puts "Uploading image: #{image_set.to_s}"
              @connection.put_picture(image_set.first.source, {:message => image_set.caption}, album.id)
            end
          end
        end
      end

      def album(name)
        ThrowIf.is_nil? name, "name"
        puts "Looking for album: #{name}."

        results = @connection.get_connections(profile, Constants::ALBUMS, {Constants::FIELDS => [Constants::ID, Constants::NAME, Constants::DESCRIPTION]})
        result = results.select {|result| result[Constants::NAME] === name}
        album = nil

        unless result.nil? or result.empty?
          puts "Found it!"
          remote_object = result.first
          album = Album.new(name, remote_object[Constants::DESCRIPTION], remote_object[Constants::ID])
          results = @connection.get_connections(
                      remote_object[Constants::ID],
                      Constants::PHOTOS,
                      {
                        Constants::FIELDS => [
                          Constants::NAME,
                          Constants::IMAGES
                        ]
                      })
          loop do
            populate_album_from_results(album, results)
            results = results.next_page

            if results.nil?
              break
            end
          end

          puts "Found #{album.size} pictures in the album."
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
