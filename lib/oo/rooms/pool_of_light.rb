class PoolOfLight < Room

  def go_direction(verb)
    if [Oo::Direction::N, Oo::Direction::E].include?(verb) && (!@inventory.carrying?(Oo::Things::CANDLE) ||
        !@inventory.thing(Oo::Things::CANDLE).is_lit?)
      ["You need a light.", self]
    else
      super(verb)
    end
  end
end