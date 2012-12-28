class Room
  attr_accessor :routes, :description, :objects

  def initialize(description, objects = [])
    @routes = {}
    @description = description
    @objects = objects
  end
end