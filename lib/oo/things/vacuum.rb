class Vacuum < Thing
  def initialize
    @turned_on = false
  end

  def use(inventory, rooms)
    if inventory.carrying?(Oo::Things::BATTERIES)
      @turned_on = true
      message = "Switched on."
    end
    if @turned_on && rooms.current_room.words.keys.include?("GHOSTS")
      message = rooms.current_room.words["GHOSTS"].vacuum(rooms)
    end
    message
  end
end