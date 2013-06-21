class Key < Thing
  def unlock(house)
    house.current_room.unlock_door
  end
end