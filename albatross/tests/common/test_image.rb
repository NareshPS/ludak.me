require 'minitest/autorun'
require_relative '../../common/image'

module Albatross
  class TestImage < Minitest::Spec
    attr_reader :image

    def setup
      @image ||= Image.new 'test_image', 10, 5, "jpg"
    end

    def test_qualified_name
      assert_equal "test_image_10X5.jpg", image.qualified_name
    end

    def test_initialize_nil_params
      -> {Image.new nil, 1, 1, "jpg"}.must_raise ArgumentError
    end

    def test_to_s
      assert_equal '|Source: test_image Width: 10 Height: 5 Type: jpg|', @image.to_s
    end
  end
end
