require_relative 'throw_if'

=begin
  Represents an image.
=end
module Albatross
  class Image
    attr_accessor :source
    attr_reader :width, :height, :type

    def initialize(source, width = 0, height = 0, type = "jpg")
      ThrowIf.is_nil? source, "source"
      @source = source
      @width = width
      @height = height
      @type = type
    end

    def qualified_name
      "#{source}_#{width}X#{height}.#{type}"
    end

    def to_s()
      return "|Source: #{source} Width: #{width} Height: #{height} Type: #{type}|"
    end
  end
end
