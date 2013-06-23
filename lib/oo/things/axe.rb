class Axe < Thing
  def swing(rooms)
    rooms.current_room.swing_axe
  end
end