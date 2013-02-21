module Oo
  module Command
    class SprayCommand

      def verbs
        ["SPRAY"]
      end

      def execute(verb, word, house)
        current_room = house.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].spray(house)
          current_room.objects << thing unless thing.nil?
          return message
        end
        house.thing(word).examine if house.carrying?(word)
      end
    end
  end
end