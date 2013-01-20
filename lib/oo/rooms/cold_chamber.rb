class ColdChamber < Room

  def initialize(description, things=[], objects=[])
    super(description, things, objects)
    @magical_barrier = true
  end

  def magic_occurs(house)
    @magical_barrier = false
  end

  def go_direction(verb)
    if @magical_barrier
      "A magical barrier to the west."
    else
      super(verb)
    end
  end
end