require_relative './Profile'
require_relative './AccessToken'

require 'optparse'
require 'yaml'

@AlbumList = %w{Alaska Japan Peru Rome Netherlands Barcelona Colorado Ecuador}
@AlbumDataDir = '_data'
@AlbumDataFileExtension = '.yaml'

def getAlbumFilePath(album)
  return File.join(@AlbumDataDir, album + @AlbumDataFileExtension)
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: Main.rb [options]"

  opts.on("-w", "--write", "Write album yaml to disk") do |v|
    options[:write] = v
  end
end.parse!

profile = Profile.new(AccessToken.get)
albums = profile.albums @AlbumList
profile.photos albums

albums.each do |album|
  # Delete big photos
  album.each do |photo|
    photo.delete_if { |image| image.height > 800}
  end

  if options[:write]
    File.open(getAlbumFilePath(album.name), 'w') do |file|
      YAML.dump(album, file)
    end
  end
end
