class SprayCommand

  def verbs
    ["SPRAY"]
  end

  def execute(verb, word, house)
    house.thing(word).swing(house) if house.carrying?(word)
  end
end