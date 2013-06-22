class DarkRoom < Room

  def initialize(house, rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
    @house = house
  end

  def go_direction(verb)
    if !@house.carrying?(Oo::Inventory::CANDLE) && !@house.thing(Oo::Inventory::CANDLE).is_lit?
      "Too dark to move."
    else
      super(verb)
    end
  end
end