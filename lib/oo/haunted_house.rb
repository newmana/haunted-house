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

      Room.new(self, @rooms, "Dark Corner")
      Room.new(self, @rooms, "Overgrown Garden")
      Room.new(self, @rooms, "By a Large Wood Pile", [], [AXE])
      Room.new(self, @rooms, "Yard by Rubbish", [Rubbish.new])
      Room.new(self, @rooms, "Weed Patch", [], [SHOVEL])
      Room.new(self, @rooms, "Forest")
      Room.new(self, @rooms, "Thick Forest")
      BlastedTree.new(self, @rooms, "Blasted Tree", [], [ROPE])

      Room.new(self, @rooms, "Corner of the House")
      Room.new(self, @rooms, "Entrance to the Kitchen")
      Room.new(self, @rooms, "Kitchen and Grimy Cooker", [], [MATCHES])
      Room.new(self, @rooms, "Scullery Door")
      Room.new(self, @rooms, "Room with Inches of Dust")
      RearTurret.new(self, @rooms, "Rear Turret Room", [Bats.new], [SCROLL])
      Room.new(self, @rooms, "Clearing by House")
      Room.new(self, @rooms, "Path")

      Room.new(self, @rooms, "Side of the House")
      Room.new(self, @rooms, "Back of the Hallway")
      Room.new(self, @rooms, "Dark Alcove", [], [COINS])
      Room.new(self, @rooms, "Small Dark Room")
      Room.new(self, @rooms, "Bottom of a Spiral Staircase")
      Room.new(self, @rooms, "Wide Passage")
      Room.new(self, @rooms, "Slippery Steps")
      Room.new(self, @rooms, "Clifftop")

      Room.new(self, @rooms, "Near a Crumbling Wall")
      Room.new(self, @rooms, "Gloomy Passage", [], [VACUUM])
      PoolOfLight.new(self, @rooms, "Pool of Light", [], [BATTERIES])
      DarkRoom.new(self, @rooms, "Impressive Vaulted Hallway")
      Hall.new(self, @rooms, "Hall by a Thick Wooden Door", [Door.new], [STATUE])
      DarkRoom.new(self, @rooms, "Trophy Room")
      Cellar.new(self, @rooms, "Cellar with Barred Window")
      Room.new(self, @rooms, "Cliff Path")

      Room.new(self, @rooms, "Cupboard with Hanging Coat", [Coat.new], [])
      Room.new(self, @rooms, "Front Hall")
      Room.new(self, @rooms, "Sitting Room")
      Room.new(self, @rooms, "Secret Room", [], [MAGIC_SPELLS])
      Room.new(self, @rooms, "Steep Marble Stairs")
      Room.new(self, @rooms, "Dining Room")
      Room.new(self, @rooms, "Deep Cellar with a Coffin", [Coffin.new], [])
      Room.new(self, @rooms, "Cliff Path")

      Room.new(self, @rooms, "Closet")
      Room.new(self, @rooms, "Front Lobby")
      Room.new(self, @rooms, "Library of Evil Books", [Books.new], [CANDLESTICK])
      Study.new(self, @rooms, "Study with a Desk and Hole in the Wall", [DeskDrawer.new, Wall.new], [])
      Room.new(self, @rooms, "Weird Cobwebby Room")
      ColdChamber.new(self, @rooms, "Very Cold Chamber")
      Room.new(self, @rooms, "Spooky Room", [], [PAINTING])
      Boating.new(self, @rooms, "Cliff Path by the Marsh", [], [BOAT])

      Room.new(self, @rooms, "Rubble-Strewn Verandah")
      FrontPorch.new(self, @rooms, "Front Porch")
      Room.new(self, @rooms, "Front Tower", [], [GOBLET])
      Room.new(self, @rooms, "Sloping Corridor")
      UpperGallery.new(self, @rooms, "Upper Gallery", [Ghosts.new], [])
      Boating.new(self, @rooms, "Marsh by a Wall")
      Marsh.new(self, @rooms, "Marsh")
      Boating.new(self, @rooms, "Soggy Path")

      Room.new(self, @rooms, "By a Twisted Railing")
      Path.new(self, @rooms, "Path through an Iron Gate")
      Room.new(self, @rooms, "By Railings")
      Room.new(self, @rooms, "Beneath the Front Tower")
      Room.new(self, @rooms, "Debris from Crumbling Facade", [], [AEROSOL])
      Room.new(self, @rooms, "Large Fallen Brick Work")
      Room.new(self, @rooms, "Rotting Stone Arch")
      Room.new(self, @rooms, "Crumbling Clifftop")

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
