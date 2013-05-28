class Shovel < Thing
  def dig(house)
    house.current_room.dig_shovel
  end
end