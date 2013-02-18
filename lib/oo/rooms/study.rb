class Study < Room

  def initialize(rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
  end

  def swing_axe
    self.description = "Study with a secret room."
    @rooms.route(43, [Direction::W, Direction::N])
    "You broke the thin wall."
  end
end