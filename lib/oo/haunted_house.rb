require_relative './rooms/room'
require_relative 'direction'
require_relative 'rooms'
require_relative 'command/parser'

module Oo
  class HauntedHouse
    attr_reader :rooms

    include Direction

    def initialize(start_room=57)
      @rooms = Rooms.new
      @rooms.routes([
        [S, E], [E], [E], [S, E], [E], [E], [S, E], [S],
        [S], [S, E], [E], [], [S, E], [], [E], [S],
        [S], [S], [S, E], [E], [U, D], [S, E], [U, D], [S],
        [], [S], [S, E], [E], [E], [S], [S], [S],
        [S], [S, E], [S], [], [S, U, D], [], [], [S],
        [E], [], [E], [], [S, E], [E], [], [S],
        [S, E], [N, S], [E], [E], [], [S], [S], [W],
        [E], [E], [E], [E], [E], [E], [E], []
      ])
      @rooms.room(start_room)
    end

    def welcome
      p = Oo::Command::Parser.new(self)
      message = "Ok"
      while true
        @rooms.current_room.show(message)
        message = ""
        message += @rooms.inventory.time
        message += p.parse_input(gets)
      end
    end
  end
end
