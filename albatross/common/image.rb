require_relative 'throw_if'

=begin
  Represents an image.
=end
module Albatross
  class Image
    attr_accessor :source
    attr_reader :scale, :type

    def initialize(source, scale = 1.0, type = "jpg")
      ThrowIf.is_nil? source, "source"
      @source = source
      @scale = scale
      @type = type
    end

    def qualified_name
      "#{source}_#{scale}.#{type}"
    end

    def to_s()
      return "|Source: #{source} Scale: #{scale} Type: #{type}|"
    end
  end
end
