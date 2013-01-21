class RearTurret < Room

  def initialize(description, things=[], objects=[])
    super(description, things, objects)
    @can_have_bats = true
  end

  def spray_bats
    @can_have_bats = false
  end

  def bats
    @can_have_bats && Random.new.rand(3) != 2
  end
end