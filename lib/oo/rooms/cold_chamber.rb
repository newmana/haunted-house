class ColdChamber < Room

  def initialize(inventory, rooms, description, things=[], objects=[])
    super(inventory, rooms, description, things, objects)
    @magical_barrier = true
  end

  def magic_occurs
    @magical_barrier = false
  end

  def go_direction(verb)
    if @magical_barrier && @inventory.carrying?(Oo::Things::PAINTING)
      ["A magical barrier to the west.", self]
    else
      super(verb)
    end
  end
end