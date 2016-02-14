
module Albatross
  module Azure
    class Utilities
      def self.get_blob_url(account, container, blob_name)
        "https://#{account}.blob.core.windows.net/#{container}/#{blob_name}"
      end
    end
  end
end
