require 'pathname'
require 'optparse'


@AlbumList = %w{Alaska Japan Peru Rome Netherlands Barcelona}
@AlbumDataDir = '_data'
@AlbumDataFileExtension = '.yaml'

def getAlbumFilePath(album)
  return File.join(@AlbumDataDir, album + @AlbumDataFileExtension)
end

options = {}
optparser = OptionParser.new do |opts|
  opts.banner = "Usage: Main.rb [options]"

  opts.on "-sSOURCE-DIR", "--source-dir=SOURCE-DIR", "Source directory" do |v|
    options['source-dir'] = v
  end

  opts.on "-dDESTINATION-DIR", "--destination-dir=DESTINATION-DIR", "Destination directory" do |v|
    options['destination-dir'] = v
  end

  opts.on "-aALBUM", "--album=ALBUM", "Album to resize in source directory" do |v|
    options['album'] = v
  end
end.parse!

puts options['source-dir'], options['destination-dir']

album_path = File.join options['source-dir'], options['album']
album_pn = Pathname.new album_path

abort "Missing" if not album_pn.exist?

photos = album_pn.children with_directory=false do |child_pn|
  child_pn.fnmatch "*.jpg" do |image_pn|

  end
end

puts photos

=begin
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
=end

