require_relative 'display_list'

module Oo
  module Command
    class CarryingCommand
      include DisplayList

      def verbs
        ["CARRYING?"]
      end

      def execute(verb, word, house)
        display_list("You are carrying:", house.objects.keys)
      end
    end
  end
end
