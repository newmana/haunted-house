class ColdChamber < Room

  def initialize(house, description, things=[], objects=[])
    super(description, things, objects)
    @magical_barrier = true
    @house = house
  end

  def magic_occurs(house)
    @magical_barrier = false
  end

  def go_direction(verb)
    if @magical_barrier && @house.carrying?(Inventory::PAINTING)
      ["A magical barrier to the west.", self]
    else
      super(verb)
    end
  end
end