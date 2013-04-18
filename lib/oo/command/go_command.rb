module Oo
  module Command
    class GoCommand

      def initialize
        @valid_directions = %w(NORTH SOUTH EAST WEST UP DOWN)
      end

      def verbs
        ["GO", "N", "S", "E", "W", "U", "D"]
      end

      def execute(verb, word, house)
        if verb.eql?("GO")
          if @valid_directions.include?(word)
            verb = word[0]
          else
            return "Go where?"
          end
        end
        house.rooms.go(verb)
      end
    end
  end
end

