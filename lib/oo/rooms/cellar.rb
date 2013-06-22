class Cellar < Room

  def dig_shovel
    self.description = "Hole in the wall."
    @rooms.route(30, [Oo::Direction::N, Oo::Direction::S, Oo::Direction::E])
    "Dug the bars out."
  end
end