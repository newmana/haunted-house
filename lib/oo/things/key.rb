class Key < Thing
  def unlock(rooms)
    rooms.current_room.unlock_door
  end
end