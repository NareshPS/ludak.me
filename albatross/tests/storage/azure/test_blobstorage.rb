require_relative '../../../storage/azure/blob_storage'

module Albatross
  module Azure
    describe BlobStorage do
      before do
        BLOB_NAME ||= "IMG_1177.jpg"
        FILE_URL ||= "https://dl.dropboxusercontent.com/s/ccfuyyhn7m6888f/IMG_1177.jpg?dl=0"
        TEST_CONTAINER ||= "test_container"
        DOWNLOAD_LOCATION ||= "/tmp"
        AZURE_BLOB_STORAGE ||= double("azure_blob_storage")
      end

      describe :get do
        it "must call get_blob in blob storage" do
          expect(AZURE_BLOB_STORAGE).to receive(:get_blob).with(TEST_CONTAINER, BLOB_NAME)
          expect(AZURE_BLOB_STORAGE).to receive(:create_container).with(TEST_CONTAINER, :public_access_level => "container")
          blob_storage = BlobStorage.new(TEST_CONTAINER, DOWNLOAD_LOCATION, AZURE_BLOB_STORAGE)
          blob_storage.get(BLOB_NAME)
        end

        it "must return a blob" do
          expect(AZURE_BLOB_STORAGE).to receive(:get_blob) {["blob_name", "content"]}
          expect(AZURE_BLOB_STORAGE).to receive(:create_container).with(TEST_CONTAINER, :public_access_level => "container")
          blob_storage = BlobStorage.new(TEST_CONTAINER, DOWNLOAD_LOCATION, AZURE_BLOB_STORAGE)
          blob_name, content = blob_storage.get(BLOB_NAME)
          expect(blob_name).to eq("blob_name")
          expect(content).to eq("content")
        end
      end
    end
  end
end
