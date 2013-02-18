class FrontPorch < Room

  def initialize(rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
    @door_open = true
  end

  def go_direction(verb)
    if @door_open && verb.eql?(Direction::N)
      @door_open = false
      next_room = routes[Direction::N]
      @rooms.remove_route(49, Direction::N)
      return ["The door slams shut!", next_room]
    end
    super(house, verb)
  end
end