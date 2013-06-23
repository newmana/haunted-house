require_relative 'display_list'

module Oo
  module Command
    class HelpCommand
      include DisplayList

      def initialize(commands)
        @commands = commands
      end

      def verbs
        ["HELP"]
      end

      def execute(verb, word, inventory, rooms)
        display_list("Words I know:", @commands)
      end
    end
  end
end
