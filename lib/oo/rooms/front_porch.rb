class FrontPorch < Room

  def initialize(inventory, rooms, description, things=[], objects=[])
    super(inventory, rooms, description, things, objects)
    @door_open = true
  end

  def go_direction(verb)
    if @door_open && verb.eql?(Oo::Direction::N)
      @door_open = false
      next_room = routes[Oo::Direction::N]
      @rooms.remove_route(49, Oo::Direction::N)
      return ["The door slams shut!", next_room]
    end
    super(verb)
  end
end