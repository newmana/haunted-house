require_relative 'things/thing'
require_relative 'things/things'
require_relative 'inventory'
Dir[File.dirname(__FILE__) + '/things/*.rb'].each do |file|
  require_relative './things/' + File.basename(file, File.extname(file))
end
require_relative '../oo/rooms/room'
require_relative '../oo/rooms/dark_room'
require_relative '../oo/rooms/boating'
Dir[File.dirname(__FILE__) + '/rooms/*.rb'].each do |file|
  require_relative './rooms/' + File.basename(file, File.extname(file))
end

module Oo
  class Rooms
    include Oo::Direction, Oo::Things

    def initialize
      @inventory = Inventory.new
      @rooms = []
      Room.new(@inventory, self, "Dark Corner")
      Room.new(@inventory, self, "Overgrown Garden")
      Room.new(@inventory, self, "By a Large Wood Pile", [], [AXE])
      Room.new(@inventory, self, "Yard by Rubbish", [Rubbish.new])
      Room.new(@inventory, self, "Weed Patch", [], [SHOVEL])
      Room.new(@inventory, self, "Forest")
      Room.new(@inventory, self, "Thick Forest")
      BlastedTree.new(@inventory, self, "Blasted Tree", [], [ROPE])

      Room.new(@inventory, self, "Corner of the House")
      Room.new(@inventory, self, "Entrance to the Kitchen")
      Room.new(@inventory, self, "Kitchen and Grimy Cooker", [], [MATCHES])
      Room.new(@inventory, self, "Scullery Door")
      Room.new(@inventory, self, "Room with Inches of Dust")
      RearTurret.new(@inventory, self, "Rear Turret Room", [Bats.new], [SCROLL])
      Room.new(@inventory, self, "Clearing by House")
      Room.new(@inventory, self, "Path")

      Room.new(@inventory, self, "Side of the House")
      Room.new(@inventory, self, "Back of the Hallway")
      Room.new(@inventory, self, "Dark Alcove", [], [COINS])
      Room.new(@inventory, self, "Small Dark Room")
      Room.new(@inventory, self, "Bottom of a Spiral Staircase")
      Room.new(@inventory, self, "Wide Passage")
      Room.new(@inventory, self, "Slippery Steps")
      Room.new(@inventory, self, "Clifftop")

      Room.new(@inventory, self, "Near a Crumbling Wall")
      Room.new(@inventory, self, "Gloomy Passage", [], [VACUUM])
      PoolOfLight.new(@inventory, self, "Pool of Light", [], [BATTERIES])
      DarkRoom.new(@inventory, self, "Impressive Vaulted Hallway")
      Hall.new(@inventory, self, "Hall by a Thick Wooden Door", [Door.new], [STATUE])
      DarkRoom.new(@inventory, self, "Trophy Room")
      Cellar.new(@inventory, self, "Cellar with Barred Window")
      Room.new(@inventory, self, "Cliff Path")

      Room.new(@inventory, self, "Cupboard with Hanging Coat", [Coat.new], [])
      Room.new(@inventory, self, "Front Hall")
      Room.new(@inventory, self, "Sitting Room")
      Room.new(@inventory, self, "Secret Room", [], [MAGIC_SPELLS])
      Room.new(@inventory, self, "Steep Marble Stairs")
      Room.new(@inventory, self, "Dining Room")
      Room.new(@inventory, self, "Deep Cellar with a Coffin", [Coffin.new], [])
      Room.new(@inventory, self, "Cliff Path")

      Room.new(@inventory, self, "Closet")
      Room.new(@inventory, self, "Front Lobby")
      Room.new(@inventory, self, "Library of Evil Books", [Books.new], [CANDLESTICK])
      Study.new(@inventory, self, "Study with a Desk and Hole in the Wall", [DeskDrawer.new, Wall.new], [])
      Room.new(@inventory, self, "Weird Cobwebby Room")
      ColdChamber.new(@inventory, self, "Very Cold Chamber")
      Room.new(@inventory, self, "Spooky Room", [], [PAINTING])
      Boating.new(@inventory, self, "Cliff Path by the Marsh", [], [BOAT])

      Room.new(@inventory, self, "Rubble-Strewn Verandah")
      FrontPorch.new(@inventory, self, "Front Porch")
      Room.new(@inventory, self, "Front Tower", [], [GOBLET])
      Room.new(@inventory, self, "Sloping Corridor")
      UpperGallery.new(@inventory, self, "Upper Gallery", [Ghosts.new], [])
      Boating.new(@inventory, self, "Marsh by a Wall")
      Marsh.new(@inventory, self, "Marsh")
      Boating.new(@inventory, self, "Soggy Path")

      Room.new(@inventory, self, "By a Twisted Railing")
      Path.new(@inventory, self, "Path through an Iron Gate")
      Room.new(@inventory, self, "By Railings")
      Room.new(@inventory, self, "Beneath the Front Tower")
      Room.new(@inventory, self, "Debris from Crumbling Facade", [], [AEROSOL])
      Room.new(@inventory, self, "Large Fallen Brick Work")
      Room.new(@inventory, self, "Rotting Stone Arch")
      Room.new(@inventory, self, "Crumbling Clifftop")
    end

    def <<(room)
      @rooms << room
    end

    def room(index)
      @current_room = @rooms[index]
    end

    def inventory
      @inventory
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
