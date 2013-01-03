class GoCommand

  def verbs
    ["GO", "N", "S", "E", "W", "U", "D"]
  end

  def execute(verb, word, house)
    verb = verb.to_sym
    if house.current_room.routes.keys.include?(verb.to_sym)
      house.current_room = house.current_room.routes[verb]
      return "Ok"
    end
    "You can't go that way!"
  end
end