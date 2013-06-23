class Shovel < Thing
  def dig(current_room)
    current_room.dig_shovel
  end
end