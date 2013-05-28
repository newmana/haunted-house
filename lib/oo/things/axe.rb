class Axe < Thing
  def swing(house)
    house.current_room.swing_axe
  end
end