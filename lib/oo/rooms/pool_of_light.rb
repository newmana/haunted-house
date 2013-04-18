class PoolOfLight < Room

  def initialize(house, rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
    @house = house
  end

  def go_direction(verb)
    if [Oo::Direction::N, Oo::Direction::E].include?(verb) && !@house.carrying?(Oo::Inventory::CANDLE) &&
        !@house.thing(Oo::Inventory::CANDLE).is_lit?
      "You need a light."
    else
      super(verb)
    end
  end
end