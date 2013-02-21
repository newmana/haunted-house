module Oo
  module Command
    class GetTakeCommand
      def verbs
        ["GET", "TAKE"]
      end

      def execute(verb, word, house)
        return if word.nil? || word.empty?
        word = word.to_s.gsub(/ /,'_').to_sym
        return "It isn't here" unless house.current_room.objects.include?(word)
        return "You already have it" if house.carrying?(word)
        house.current_room.objects.delete(word)
        house.carry(word)
        "You have the #{word}"
      end
    end
  end
end

