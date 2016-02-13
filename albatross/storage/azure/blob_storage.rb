require 'azure'
require 'open-uri'

require_relative '../../data/azure/config'

module Albatross
  module Azure
    class BlobStorage
      attr_reader :container_name

      def initialize(container_name, download_location, azure_blob_service = ::Azure::Blob::BlobService.new)
        @azure_blob_service = azure_blob_service
        @container_name = container_name
        @download_location = download_location

        begin
          @container = @azure_blob_service.create_container(@container_name, :public_access_level => "container")
        rescue ::Azure::Core::Http::HTTPError
          $!
        end
      end

      def get(blob_name)
        blob, content = @azure_blob_service.get_blob(@container_name, blob_name)
      end

      def get_and_save(blob_name, overwrite = false)
        blob, content = get(blob_name)
        file_mode = 'wb' + (overwrite ? '+': '')
        File.open(File.join(@download_location, blob_name), 'wb') {|f| f.write(content)}
      end

      def put(blob_name, source)
        content = source =~ URI::regexp ? open(source).read : File.open(File.join(source, blob_name), 'rb') {|f| f.read}
        begin
          blob = @azure_blob_service.create_block_blob(@container_name, blob_name, content)
        rescue
          puts $!.inspect
        end
      end

      def list
        blobs = @azure_blob_service.list_blobs(@container_name)
        blobs.map {|blob| blob.name}
      end
    end
  end
end
