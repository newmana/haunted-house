class ClimbCommand

  def verbs
    ["CLIMB"]
  end

  def execute(verb, word, house)
    if house.carrying?(word)
      house.thing(word).climb
    else
      house.current_room.climb
    end
  end
end