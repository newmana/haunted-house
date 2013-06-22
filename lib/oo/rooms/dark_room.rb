class DarkRoom < Room

  def go_direction(verb)
    if !@house.carrying?(Oo::Inventory::CANDLE) && !@house.thing(Oo::Inventory::CANDLE).is_lit?
      ["Too dark to move.", self]
    else
      super(verb)
    end
  end
end