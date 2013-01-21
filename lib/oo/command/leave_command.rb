class LeaveCommand
  def verbs
    ["LEAVE"]
  end

  def execute(verb, word, house)
    if house.carrying?(word)
      house.leave(word)
      house.current_room.objects << house.to_up_sym(word)
      "Done"
    end
  end
end