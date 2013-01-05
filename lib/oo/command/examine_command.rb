class ExamineCommand
  def verbs
    ["EXAMINE"]
  end

  def execute(verb, word, house)
    if house.current_room.words.keys.include?(word)
      message, thing = house.current_room.words[word].examine
      house.current_room.objects << thing unless thing.nil?
      message
    end
    # TODO Fix - need to combine this with things and inventory
    if house.carrying?(word) && word.to_s.upcase.to_sym.eql?(Inventory::SCROLL)
      Scroll.new.examine
    end
  end
end