require 'yaml'
require_relative 'common/album'
require_relative 'common/image_set'
require_relative 'common/image'
require_relative 'common/throw_if'

module Albatross
  class Datastore
    NAME = "name"
    IMAGES = "images"
    CAPTION = "caption"
    SOURCE = "source"
    DESCRIPTION = "description"

    attr_reader :metadata

    def initialize(metadata)
      ThrowIf.is_nil? metadata, "metadata"
      @metadata = metadata
    end

    def get
      @album ||= load
    end

    def load
      contents = nil
      if File.exist? metadata
        contents = YAML::load(File.open(metadata))
      else
        raise ArgumentError.new "File #{metadata} not found."
      end
      contents_to_album contents
    end

    def contents_to_album contents
      album = Album.new(contents[NAME], contents[DESCRIPTION])

      contents[IMAGES].each do |image|
        image_set = ImageSet.new image[CAPTION]
        image_set.push(Image.new image[SOURCE])
        album.push image_set
      end
      album
    end
  end
end
