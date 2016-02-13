
module Albatross
  module Dropbox
    class Utilities
      @@URL_TO_FILENAME_REGEX = "\/([\w.]+)\?"

      def self.url_to_filename(url)
        match = /\/([\w.%-]+)\?/.match(url)
        match[1]
      end
    end
  end
end
