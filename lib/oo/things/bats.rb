class Bats
  def initialize
    @sprayed = false
  end

  def name
    ["BATS"]
  end

  def spray(house)
    if !@sprayed && house.inventory.carrying?(Oo::Things::AEROSOL)
      house.current_room.spray_bats
      @sprayed = true
      "Pfft! Got them."
    else
      "Hissss"
    end
  end
end