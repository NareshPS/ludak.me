
class Album < Array
  attr_reader :id, :name, :description

  def initialize(id, name, description)
    @id = id
    @name = name
    @description = description
    super()
  end

  def photos()
    Array.new(self)
  end

  def to_s()
    return "|Id: #{@id} Name: #{@name} Description: #{@description} # of Photos: #{self.length}|"
  end
end
