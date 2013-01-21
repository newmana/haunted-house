class Rope
  def name
    ["ROPE"]
  end

  def climb
    "It isn't attached to anything!"
  end

  def swing(house)
    house.current_room.swing_rope
  end
end