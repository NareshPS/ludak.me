require 'pathname'
require 'require_all'
require 'yaml'

require_rel '../common'

module Albatross
  module Metadata
    class Store
      def load(source)
        contents = nil
        if File.exist? source
          contents = YAML::load(File.open(source))
        else
          raise ArgumentError.new "File #{source} not found."
        end
        contents_to_album contents
      end

      def store(album, destination)
        unless album.nil?
          contents = album_to_contents(album)
          File.open(destination, 'w') {|f| f.write contents.to_yaml}
        end
      end

      private
      def contents_to_album contents
        album = Album.new(contents[Constants::NAME], contents[Constants::DESCRIPTION])

        unless contents[Constants::IMAGES].nil?
          contents[Constants::IMAGES].each do |image|
            image_set = ImageSet.new image[Constants::CAPTION]
            image_set.push(Image.new image[Constants::SOURCE])
            album.push image_set
          end
        end
        album
      end

      def album_to_contents(album)
        contents = Hash.new
        unless album.nil?
          contents[Constants::NAME] = album.title
          contents[Constants::DESCRIPTION] = album.caption
          contents[Constants::IMAGES] = Array.new

          album.each do |image_set|
            images = Hash.new
            images[Constants::CAPTION] = image_set.caption
            images[Constants::IMAGESET] = Array.new
            image_set.each do |image|
              images[Constants::IMAGESET].push({Constants::SOURCE => image.source, Constants::SCALE => image.scale})
            end
            contents[Constants::IMAGES].push(images)
          end
        end
        contents
      end
    end
  end
end
