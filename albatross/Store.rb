require 'pathname'

class Store
  @@Albums = "albums"
  @@Root = "../"

  def @initialize()
  end

  def self.albums()
    Pathname(@@Root).join @@Albums
  end
end
