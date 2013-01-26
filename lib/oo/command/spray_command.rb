class SprayCommand

  def verbs
    ["SPRAY"]
  end

  def execute(verb, word, house)
    if house.current_room.words.keys.include?(word)
      message, thing = house.current_room.words[word].spray(house)
      house.current_room.objects << thing unless thing.nil?
      return message
    end
    house.thing(word).examine if house.carrying?(word)
  end
end