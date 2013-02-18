class DigCommand
  def verbs
    ["DIG"]
  end

  def execute(verb, word, house)
    house.thing("SHOVEL").dig(house) if house.carrying?(Oo::Inventory::SHOVEL)
  end
end