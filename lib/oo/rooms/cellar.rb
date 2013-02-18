class Cellar < Room

  def initialize(rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
  end

  def dig_shovel
    self.description = "Hole in the wall."
    @rooms.route(30, [Oo::Direction::N, Oo::Direction::S, Oo::Direction::E])
    "Dug the bars out."
  end
end