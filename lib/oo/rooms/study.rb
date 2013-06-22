class Study < Room

  def swing_axe
    self.description = "Study with a secret room."
    @rooms.route(43, [Oo::Direction::W, Oo::Direction::N])
    "You broke the thin wall."
  end
end