class Cellar < Room

  def initialize(description, things=[], objects=[])
    super(description, things, objects)
  end

  def dig_shovel(house)
    self.description = "Hole in the wall."
    house.route(30, [Direction::N, Direction::S, Direction::E])
    "Dug the bars out."
  end
end