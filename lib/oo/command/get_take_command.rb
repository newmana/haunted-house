module Oo
  module Command
    class GetTakeCommand
      def verbs
        ["GET", "TAKE"]
      end

      def execute(verb, word, house)
        return if word.nil? || word.empty?
        symbol = word.to_s.gsub(/ /,'_').to_sym
        return "It isn't here" unless house.current_room.objects.include?(symbol)
        return "You already have it" if house.carrying?(symbol)
        house.current_room.objects.delete(symbol)
        house.carry(symbol)
        "You have the #{word}"
      end
    end
  end
end

