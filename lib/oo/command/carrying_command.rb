require_relative 'display_list'

class CarryingCommand
  include Oo::Command::DisplayList

  def verbs
    ["CARRYING?"]
  end

  def execute(verb, word, house)
    display_list("You are carrying:", house.objects.keys)
  end
end