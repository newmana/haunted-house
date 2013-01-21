class Study < Room

  def initialize(description, things=[], objects=[])
    super(description, things, objects)
  end

  def swing_axe(house)
    self.description = "Study with a secret room."
    house.route(43, [Direction::W, Direction::N])
    "You broke the thin wall."
  end
end