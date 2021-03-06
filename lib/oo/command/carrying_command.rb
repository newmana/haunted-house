require_relative 'display_list'
require_relative 'press_enter'

module Oo
  module Command
    class CarryingCommand
      include DisplayList, PressEnter

      def verbs
        ["CARRYING?"]
      end

      def execute(verb, word, inventory, rooms)
        display_list("You are carrying:", inventory.objects.keys)
      end
    end
  end
end
