class DarkRoom < Room

  def go_direction(verb)
    if !@inventory.carrying?(Oo::Things::CANDLE) && !@inventory.thing(Oo::Things::CANDLE).is_lit?
      ["Too dark to move.", self]
    else
      super(verb)
    end
  end
end