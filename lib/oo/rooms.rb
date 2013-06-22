module Oo
  class Rooms
    include Oo::Direction

    def initialize
      @rooms = []
    end

    def <<(room)
      @rooms << room
    end

    def room(index)
      @current_room = @rooms[index]
    end

    def go(verb)
      verb = verb.to_sym
      message, room = @current_room.go_direction(verb)
      @current_room = room
      message
    end

    def current_room
      @current_room
    end

    def map(index, direction)
      case direction
        when N then
          [-8, S]
        when S then
          [8, N]
        when W then
          [-1, E]
        when E then
          [1, W]
        when U
          case index
            when 20 then
              [-8, D]
            when 22 then
              [-1, D]
            when 36 then
              [8, D]
          end
        when D
          case index
            when 20 then
              [-1, U]
            when 22 then
              [8, U]
            when 36 then
              [-8, U]
          end
      end
    end

    def route(index, directions)
      directions.each do |direction|
        offset, opposite = map(index, direction)
        @rooms[index].routes.store(direction, @rooms[index + offset])
        @rooms[index + offset].routes.store(opposite, @rooms[index])
      end
    end

    def remove_route(index, direction)
      offset, opposite = map(index, direction)
      @rooms[index].routes.delete(direction)
      @rooms[index + offset].routes.delete(opposite)
    end

    def routes(all_directions)
      all_directions.each.with_index do |d, i|
        route(i, d)
      end
    end
  end
end
