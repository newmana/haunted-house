class RearTurret < Room
  attr_reader :can_have_bats

  def initialize(inventory, rooms, description, things=[], objects=[])
    super(inventory, rooms, description, things, objects)
    @can_have_bats = true
  end

  def spray_bats
    @can_have_bats = false
  end

  def bats
    @can_have_bats && Random.new.rand(3) != 2
  end

  def go_direction(verb)
    if bats
      ["Bats Attacking!", self]
    else
      super(verb)
    end
  end
end