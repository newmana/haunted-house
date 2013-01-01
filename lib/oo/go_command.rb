class GoCommand

  def verbs
    ["GO", "N", "S", "E", "W", "U", "D"]
  end

  def execute(verb, word, current_room)
    verb = verb.to_sym
    if current_room.routes.keys.include?(verb.to_sym)
      return current_room.routes[verb]
    end
    current_room
  end
end