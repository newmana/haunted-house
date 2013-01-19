class DigCommand
  def verbs
    ["DIG"]
  end

  def execute(verb, word, house)
    house.thing("SHOVEL").dig(house) if house.carrying?(Inventory::SHOVEL)
  end
end