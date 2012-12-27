class Room
  attr_accessor :routes, :description, :objects

  def initialize(routes, description, objects = [])
    @routes = routes
    @description = description
    @objects = objects
  end

  def add_object(object)
    @objects >> object
  end
end