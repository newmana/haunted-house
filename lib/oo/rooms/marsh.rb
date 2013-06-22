class Marsh < Boating

  def go_direction(verb)
    if @house.carrying?(Oo::Inventory::BOAT)
      super(verb)
    else
      ["You're stuck!", self]
    end
  end
end