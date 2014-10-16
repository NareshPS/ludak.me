
class Album
  attr_reader :id, :name, :description
  attr_accessor :photos

  def initialize(id, name, description)
    @id = id
    @name = name
    @description = description
  end

  def to_s()
    return "Id: #{@id} Name: #{@name} Description: #{@description}"
  end
end
