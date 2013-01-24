class ReadCommand
  def verbs
    ["READ"]
  end

  def execute(verb, word, house)
    if house.current_room.words.keys.include?(word)
      message, thing = house.current_room.words[word].read
      house.current_room.objects << thing unless thing.nil?
      return message
    end
    house.thing(word).read if house.carrying?(word)
  end
end