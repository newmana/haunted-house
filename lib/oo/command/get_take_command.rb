module Oo
  module Command
    class GetTakeCommand
      def verbs
        ["GET", "TAKE"]
      end

      def execute(verb, word, inventory, rooms)
        return if word.nil? || word.empty?
        symbol = word.to_s.gsub(/ /,'_').to_sym
        return "It isn't here" unless rooms.current_room.objects.include?(symbol)
        return "You already have it" if inventory.carrying?(symbol)
        rooms.current_room.objects.delete(symbol)
        inventory.carry(symbol)
        "You have the #{word}"
      end
    end
  end
end

