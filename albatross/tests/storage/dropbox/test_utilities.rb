require 'minitest/autorun'
require 'minitest/mock'

require_relative '../../../storage/dropbox/utilities'

module Albatross
  module Dropbox
    describe Utilities do
      before do
        DROPBOX_URL = "https://dl.dropboxusercontent.com/s/ccfuyyhn7m6888f/IMG_1177.jpg?dl=0"
      end

      describe :url_to_filename do
        it "must return image name for the dropbox url" do
          assert_equal  "IMG_1177.jpg", Utilities.url_to_filename(DROPBOX_URL)
        end
      end
    end
  end
end
