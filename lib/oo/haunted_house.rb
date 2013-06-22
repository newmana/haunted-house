require_relative './rooms/room'
require_relative 'direction'
require_relative 'rooms'
require_relative 'inventory'
require_relative 'command/parser'
require_relative 'things/thing'
Dir[File.dirname(__FILE__) + '/things/*.rb'].each do |file|
  require_relative './things/' + File.basename(file, File.extname(file))
end
Dir[File.dirname(__FILE__) + '/rooms/*.rb'].each do |file|
  require_relative './rooms/' + File.basename(file, File.extname(file))
end

module Oo
  class HauntedHouse
    attr_reader :rooms

    include Direction, Inventory

    def initialize(start_room=57)
      super()

      @rooms = Rooms.new

      Room.new(@rooms, "Dark Corner")
      Room.new(@rooms, "Overgrown Garden")
      Room.new(@rooms, "By a Large Wood Pile", [], [AXE])
      Room.new(@rooms, "Yard by Rubbish", [Rubbish.new])
      Room.new(@rooms, "Weed Patch", [], [SHOVEL])
      Room.new(@rooms, "Forest")
      Room.new(@rooms, "Thick Forest")
      BlastedTree.new(@rooms, "Blasted Tree", [], [ROPE])

      Room.new(@rooms, "Corner of the House")
      Room.new(@rooms, "Entrance to the Kitchen")
      Room.new(@rooms, "Kitchen and Grimy Cooker", [], [MATCHES])
      Room.new(@rooms, "Scullery Door")
      Room.new(@rooms, "Room with Inches of Dust")
      RearTurret.new(@rooms, "Rear Turret Room", [Bats.new], [SCROLL])
      Room.new(@rooms, "Clearing by House")
      Room.new(@rooms, "Path")

      Room.new(@rooms, "Side of the House")
      Room.new(@rooms, "Back of the Hallway")
      Room.new(@rooms, "Dark Alcove", [], [COINS])
      Room.new(@rooms, "Small Dark Room")
      Room.new(@rooms, "Bottom of a Spiral Staircase")
      Room.new(@rooms, "Wide Passage")
      Room.new(@rooms, "Slippery Steps")
      Room.new(@rooms, "Clifftop")

      Room.new(@rooms, "Near a Crumbling Wall")
      Room.new(@rooms, "Gloomy Passage", [], [VACUUM])
      PoolOfLight.new(self, @rooms, "Pool of Light", [], [BATTERIES])
      DarkRoom.new(self, @rooms, "Impressive Vaulted Hallway")
      Hall.new(self, @rooms, "Hall by a Thick Wooden Door", [Door.new], [STATUE])
      DarkRoom.new(self, @rooms, "Trophy Room")
      Cellar.new(@rooms, "Cellar with Barred Window")
      Room.new(@rooms, "Cliff Path")

      Room.new(@rooms, "Cupboard with Hanging Coat", [Coat.new], [])
      Room.new(@rooms, "Front Hall")
      Room.new(@rooms, "Sitting Room")
      Room.new(@rooms, "Secret Room", [], [MAGIC_SPELLS])
      Room.new(@rooms, "Steep Marble Stairs")
      Room.new(@rooms, "Dining Room")
      Room.new(@rooms, "Deep Cellar with a Coffin", [Coffin.new], [])
      Room.new(@rooms, "Cliff Path")

      Room.new(@rooms, "Closet")
      Room.new(@rooms, "Front Lobby")
      Room.new(@rooms, "Library of Evil Books", [Books.new], [CANDLESTICK])
      Study.new(@rooms, "Study with a Desk and Hole in the Wall", [DeskDrawer.new, Wall.new], [])
      Room.new(@rooms, "Weird Cobwebby Room")
      ColdChamber.new(self, @rooms, "Very Cold Chamber")
      Room.new(@rooms, "Spooky Room", [], [PAINTING])
      Room.new(@rooms, "Cliff Path by the Marsh", [], [BOAT])

      Room.new(@rooms, "Rubble-Strewn Verandah")
      FrontPorch.new(@rooms, "Front Porch")
      Room.new(@rooms, "Front Tower", [], [GOBLET])
      Room.new(@rooms, "Sloping Corridor")
      UpperGallery.new(@rooms, "Upper Gallery", [Ghosts.new], [])
      Room.new(@rooms, "Marsh by a Wall")
      Room.new(@rooms, "Marsh")
      Room.new(@rooms, "Soggy Path")

      Room.new(@rooms, "By a Twisted Railing")
      Path.new(@rooms, "Path through an Iron Gate")
      Room.new(@rooms, "By Railings")
      Room.new(@rooms, "Beneath the Front Tower")
      Room.new(@rooms, "Debris from Crumbling Facade", [], [AEROSOL])
      Room.new(@rooms, "Large Fallen Brick Work")
      Room.new(@rooms, "Rotting Stone Arch")
      Room.new(@rooms, "Crumbling Clifftop")

      @rooms.routes([
        [S, E], [E], [E], [S, E], [E], [E], [S, E], [S],
        [S], [S, E], [E], [], [S, E], [], [E], [S],
        [S], [S], [S, E], [E], [U, D], [S, E], [U, D], [S],
        [], [S], [S, E], [E], [E], [S], [S], [S],
        [S], [S, E], [S], [S], [S, U, D], [], [], [S],
        [E], [], [E], [], [S, E], [E], [], [S],
        [S, E], [N, S], [E], [E], [], [S], [S], [W],
        [E], [E], [E], [E], [E], [E], [E], []
      ])

      @rooms.room(start_room)
    end

    def current_room
      @rooms.current_room
    end

    def welcome
      p = Oo::Command::Parser.new(self)
      message = "Ok"
      while true
        @rooms.current_room.show(message)
        message = ""
        message += time
        message += p.parse_input(gets)
      end
    end
  end
end
