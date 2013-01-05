class OpenCommand
  def verbs
    ["OPEN"]
  end

  def execute(verb, word, house)
    if house.current_room.words.keys.include?(word)
      message, thing = house.current_room.words[word].open
      house.current_room.objects << thing
      message
    end
  end
end