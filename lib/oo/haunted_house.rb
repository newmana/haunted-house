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
    attr_reader :rooms, :inventory

    include Direction, Things

    def initialize(start_room=57)
      super()

      @inventory = Inventory.new
      @rooms = Rooms.new

      Room.new(@inventory, @rooms, "Dark Corner")
      Room.new(@inventory, @rooms, "Overgrown Garden")
      Room.new(@inventory, @rooms, "By a Large Wood Pile", [], [AXE])
      Room.new(@inventory, @rooms, "Yard by Rubbish", [Rubbish.new])
      Room.new(@inventory, @rooms, "Weed Patch", [], [SHOVEL])
      Room.new(@inventory, @rooms, "Forest")
      Room.new(@inventory, @rooms, "Thick Forest")
      BlastedTree.new(@inventory, @rooms, "Blasted Tree", [], [ROPE])

      Room.new(@inventory, @rooms, "Corner of the House")
      Room.new(@inventory, @rooms, "Entrance to the Kitchen")
      Room.new(@inventory, @rooms, "Kitchen and Grimy Cooker", [], [MATCHES])
      Room.new(@inventory, @rooms, "Scullery Door")
      Room.new(@inventory, @rooms, "Room with Inches of Dust")
      RearTurret.new(@inventory, @rooms, "Rear Turret Room", [Bats.new], [SCROLL])
      Room.new(@inventory, @rooms, "Clearing by House")
      Room.new(@inventory, @rooms, "Path")

      Room.new(@inventory, @rooms, "Side of the House")
      Room.new(@inventory, @rooms, "Back of the Hallway")
      Room.new(@inventory, @rooms, "Dark Alcove", [], [COINS])
      Room.new(@inventory, @rooms, "Small Dark Room")
      Room.new(@inventory, @rooms, "Bottom of a Spiral Staircase")
      Room.new(@inventory, @rooms, "Wide Passage")
      Room.new(@inventory, @rooms, "Slippery Steps")
      Room.new(@inventory, @rooms, "Clifftop")

      Room.new(@inventory, @rooms, "Near a Crumbling Wall")
      Room.new(@inventory, @rooms, "Gloomy Passage", [], [VACUUM])
      PoolOfLight.new(@inventory, @rooms, "Pool of Light", [], [BATTERIES])
      DarkRoom.new(@inventory, @rooms, "Impressive Vaulted Hallway")
      Hall.new(@inventory, @rooms, "Hall by a Thick Wooden Door", [Door.new], [STATUE])
      DarkRoom.new(@inventory, @rooms, "Trophy Room")
      Cellar.new(@inventory, @rooms, "Cellar with Barred Window")
      Room.new(@inventory, @rooms, "Cliff Path")

      Room.new(@inventory, @rooms, "Cupboard with Hanging Coat", [Coat.new], [])
      Room.new(@inventory, @rooms, "Front Hall")
      Room.new(@inventory, @rooms, "Sitting Room")
      Room.new(@inventory, @rooms, "Secret Room", [], [MAGIC_SPELLS])
      Room.new(@inventory, @rooms, "Steep Marble Stairs")
      Room.new(@inventory, @rooms, "Dining Room")
      Room.new(@inventory, @rooms, "Deep Cellar with a Coffin", [Coffin.new], [])
      Room.new(@inventory, @rooms, "Cliff Path")

      Room.new(@inventory, @rooms, "Closet")
      Room.new(@inventory, @rooms, "Front Lobby")
      Room.new(@inventory, @rooms, "Library of Evil Books", [Books.new], [CANDLESTICK])
      Study.new(@inventory, @rooms, "Study with a Desk and Hole in the Wall", [DeskDrawer.new, Wall.new], [])
      Room.new(@inventory, @rooms, "Weird Cobwebby Room")
      ColdChamber.new(@inventory, @rooms, "Very Cold Chamber")
      Room.new(@inventory, @rooms, "Spooky Room", [], [PAINTING])
      Boating.new(@inventory, @rooms, "Cliff Path by the Marsh", [], [BOAT])

      Room.new(@inventory, @rooms, "Rubble-Strewn Verandah")
      FrontPorch.new(@inventory, @rooms, "Front Porch")
      Room.new(@inventory, @rooms, "Front Tower", [], [GOBLET])
      Room.new(@inventory, @rooms, "Sloping Corridor")
      UpperGallery.new(@inventory, @rooms, "Upper Gallery", [Ghosts.new], [])
      Boating.new(@inventory, @rooms, "Marsh by a Wall")
      Marsh.new(@inventory, @rooms, "Marsh")
      Boating.new(@inventory, @rooms, "Soggy Path")

      Room.new(@inventory, @rooms, "By a Twisted Railing")
      Path.new(@inventory, @rooms, "Path through an Iron Gate")
      Room.new(@inventory, @rooms, "By Railings")
      Room.new(@inventory, @rooms, "Beneath the Front Tower")
      Room.new(@inventory, @rooms, "Debris from Crumbling Facade", [], [AEROSOL])
      Room.new(@inventory, @rooms, "Large Fallen Brick Work")
      Room.new(@inventory, @rooms, "Rotting Stone Arch")
      Room.new(@inventory, @rooms, "Crumbling Clifftop")

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

    def welcome
      p = Oo::Command::Parser.new(@house)
      message = "Ok"
      while true
        current_room.show(message)
        message = ""
        message += inventory.time
        message += p.parse_input(gets)
      end
    end
  end
end
