class Shovel
  def name
    ["SHOVEL"]
  end

  def dig(house)
    house.current_room.dig_shovel
  end
end