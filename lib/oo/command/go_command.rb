class GoCommand

  def verbs
    ["GO", "N", "S", "E", "W", "U", "D"]
  end

  def execute(verb, word, house)
    verb = verb.to_sym
    message, room = house.current_room.go_direction(verb)
    house.current_room = room
    message
  end
end