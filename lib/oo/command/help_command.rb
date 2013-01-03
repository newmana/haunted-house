require './lib/oo/display_list'

class HelpCommand
  include DisplayList

  def initialize(commands)
    @commands = commands
  end

  def verbs
    ["HELP"]
  end

  def execute(verb, word, house)
    display_list("Words I know:", @commands)
  end
end