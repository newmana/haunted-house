class Axe
  def name
    ["AXE"]
  end

  def swing(house)
    house.current_room.swing_axe(house)
  end
end