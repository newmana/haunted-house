class CarryingCommand
  include DisplayList

  def verbs
    ["CARRYING?"]
  end

  def execute(verb, word, house)
    display_list("You are carrying:", house.objects.keys)
  end
end