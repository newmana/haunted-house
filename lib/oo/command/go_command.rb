class GoCommand

  def verbs
    ["GO", "N", "S", "E", "W", "U", "D"]
  end

  def execute(verb, word, house)
    house.rooms.go(verb)
  end
end