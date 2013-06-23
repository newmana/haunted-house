class Bats
  def initialize
    @sprayed = false
  end

  def name
    ["BATS"]
  end

  def spray(inventory, rooms)
    if !@sprayed && inventory.carrying?(Oo::Things::AEROSOL)
      rooms.current_room.spray_bats
      @sprayed = true
      "Pfft! Got them."
    else
      "Hissss"
    end
  end
end