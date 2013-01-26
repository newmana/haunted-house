class Bats
  def name
    ["BATS"]
  end

  def spray(house)
    house.current_room.spray_bats if house.carrying?(Inventory::AEROSOL)
  end
end