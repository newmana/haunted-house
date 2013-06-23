module Oo
  module Command
    class OpenCommand
      def verbs
        ["OPEN"]
      end

      def execute(verb, word, inventory, rooms)
        current_room = rooms.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].open
          current_room.objects << thing unless thing.nil?
          message
        end
      end
    end
  end
end