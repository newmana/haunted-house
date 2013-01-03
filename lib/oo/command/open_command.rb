class LeaveCommand
  def verbs
    ["OPEN"]
  end

  def execute(verb, word, house)
    house.current_room.words[word] if house.current_room.words.keys.include?(word)
  end
end