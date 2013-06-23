class UpperGallery < Room
  def initialize(inventory, rooms, description, things=[], objects=[])
    super(inventory, rooms, description, things, objects)
    @can_have_ghosts = true
    @has_ghosts = false
  end

  def vacuum_ghosts
    @can_have_ghosts = false
    @has_ghosts = false
  end

  def ghosts
    @has_ghosts = Random.new.rand(2) == 1 if @can_have_ghosts
    @has_ghosts
  end

  def go_direction(verb)
    ghosts
    if @has_ghosts
      ["Ghosts will not let you move.", self]
    else
      super(verb)
    end
  end
end