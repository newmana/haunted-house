class ColdChamber < Room

  def initialize(house, rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
    @magical_barrier = true
    @house = house
  end

  def magic_occurs
    @magical_barrier = false
  end

  def go_direction(verb)
    if @magical_barrier && @house.carrying?(Oo::Inventory::PAINTING)
      ["A magical barrier to the west.", self]
    else
      super(verb)
    end
  end
end