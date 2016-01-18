require_relative 'throw_if'

=begin
  Represents an image.
=end
module Albatross
  class Image
    attr_reader :name, :width, :height, :type

    def initialize(name, width, height, type)
      ThrowIf::is_nil? name, "name"
      ThrowIf::is_nil? width, "width"
      ThrowIf::is_nil? height, "height"
      ThrowIf::is_nil? type, "type"
      @name = name
      @width = width
      @height = height
      @type = type
    end

    def qualified_name
      "#{name}_#{width}X#{height}.#{type}"
    end

    def to_s()
      return "|Name: #{name} Width: #{width} Height: #{height} Type: #{type}|"
    end
  end
end
