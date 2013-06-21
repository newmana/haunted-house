class Hall < Room

  def initialize(rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
    @door_locked = true
  end

  def unlock_door
    if @door_locked
      @door_locked = false
      self.description = "Huge open door."
      @rooms.route(28, [Oo::Direction::S, Oo::Direction::E, Oo::Direction::W])
      "The key turns!"
    end
  end
end