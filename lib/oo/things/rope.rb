class Rope < Thing
  def climb
    "It isn't attached to anything!"
  end

  def swing(rooms)
    rooms.current_room.swing_rope
  end
end