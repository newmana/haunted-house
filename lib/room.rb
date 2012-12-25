class Room
  attr_accessor :routes, :description

  def initialize(routes, description)
    @routes = routes
    @description = description
  end
end