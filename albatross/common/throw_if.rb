=begin
  Argument validation functionality.
=end
module Albatross
  class ThrowIf
    def self.is_nil?(object, name)
      raise ArgumentError, "#{name} is nil" if object.nil?
    end
  end
end
