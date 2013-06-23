class Marsh < Boating

  def go_direction(verb)
    if @inventory.carrying?(Oo::Things::BOAT)
      super(verb)
    else
      ["You're stuck!", self]
    end
  end
end