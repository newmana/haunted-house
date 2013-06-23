class Vacuum < Thing
  def initialize
    @turned_on = false
  end

  def use(house)
    if house.inventory.carrying?(Oo::Things::BATTERIES)
      @turned_on = true
      message = "Switched on."
    end
    if @turned_on && house.current_room.words.keys.include?("GHOSTS")
      message = house.current_room.words["GHOSTS"].vacuum(house)
    end
    message
  end
end