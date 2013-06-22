class PoolOfLight < Room

  def go_direction(verb)
    if [Oo::Direction::N, Oo::Direction::E].include?(verb) && (!@house.carrying?(Oo::Inventory::CANDLE) ||
        !@house.thing(Oo::Inventory::CANDLE).is_lit?)
      ["You need a light.", self]
    else
      super(verb)
    end
  end
end