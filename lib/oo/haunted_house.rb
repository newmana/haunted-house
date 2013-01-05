require './lib/oo/room'
require './lib/oo/direction'
require './lib/oo/inventory'
require './lib/oo/parser'
Dir["./lib/oo/things/*.rb"].each {|file| require file }

class HauntedHouse
  attr_accessor :current_room

  include Direction, Inventory

  def initialize(start_room)
    super()

    @rooms = []

    @rooms << Room.new("Dark Corner")
    @rooms << Room.new("Overgrown Garden")
    @rooms << Room.new("By a Large Wood Pile", [], [AXE])
    @rooms << Room.new("Yard by Rubbish", [Rubbish.new])
    @rooms << Room.new("Weed Patch", [], [SHOVEL])
    @rooms << Room.new("Forest")
    @rooms << Room.new("Thick Forest")
    @rooms << Room.new("Blasted Tree", [], [ROPE])

    @rooms << Room.new("Corner of the House")
    @rooms << Room.new("Entrance to the Kitchen")
    @rooms << Room.new("Kitchen and Grimy Cooker", [], [MATCHES])
    @rooms << Room.new("Scullery Door")
    @rooms << Room.new("Room with Inches of Dust")
    @rooms << Room.new("Rear Turret Room", [], [SCROLL])
    @rooms << Room.new("Clearing by House")
    @rooms << Room.new("Path")

    @rooms << Room.new("Side of the House")
    @rooms << Room.new("Back of the Hallway")
    @rooms << Room.new("Dark Alcove", [], [COINS])
    @rooms << Room.new("Small Dark Room")
    @rooms << Room.new("Bottom of a Spiral Staircase")
    @rooms << Room.new("Wide Passage")
    @rooms << Room.new("Slippery Steps")
    @rooms << Room.new("Clifftop")

    @rooms << Room.new("Near a Crumbling Wall")
    @rooms << Room.new("Gloomy Passage", [], [VACUUM])
    @rooms << Room.new("Pool of Light", [], [BATTERIES])
    @rooms << Room.new("Impressive Vaulted Hallway")
    @rooms << Room.new("Hall by a Thick Wooden Door", [Door.new], [STATUE])
    @rooms << Room.new("Trophy Room")
    @rooms << Room.new("Cellar with Barred Window")
    @rooms << Room.new("Cliff Path")

    @rooms << Room.new("Cupboard with Hanging Coat", [Coat.new], [])
    @rooms << Room.new("Front Hall")
    @rooms << Room.new("Sitting Room")
    @rooms << Room.new("Secret Room", [], [MAGIC_SPELLS])
    @rooms << Room.new("Steep Marble Stairs")
    @rooms << Room.new("Dining Room")
    @rooms << Room.new("Deep Cellar with a Coffin", [Coffin.new], [])
    @rooms << Room.new("Cliff Path")

    @rooms << Room.new("Closet")
    @rooms << Room.new("Front Lobby")
    @rooms << Room.new("Library of Evil Books", [Books.new], [CANDLESTICK])
    @rooms << Room.new("Study with a Desk and Hole in the Wall", [DeskDrawer.new], [])
    @rooms << Room.new("Weird Cobwebby Room")
    @rooms << Room.new("Very Cold Chamber")
    @rooms << Room.new("Spooky Room", [], [PAINTING])
    @rooms << Room.new("Cliff Path by the Marsh", [], [BOAT])

    @rooms << Room.new("Rubble-Strewn Verandah")
    @rooms << Room.new("Front Porch")
    @rooms << Room.new("Front Tower", [], [GOBLET])
    @rooms << Room.new("Sloping Corridor")
    @rooms << Room.new("Upper Gallery")
    @rooms << Room.new("Marsh by a Wall")
    @rooms << Room.new("Marsh")
    @rooms << Room.new("Soggy Path")

    @rooms << Room.new("By a Twisted Railing")
    @rooms << Room.new("Path through an Iron Gate")
    @rooms << Room.new("By Railings")
    @rooms << Room.new("Beneath the Front Tower")
    @rooms << Room.new("Debris from Crumbling Facade", [], [AEROSOL])
    @rooms << Room.new("Large Fallen Brick Work")
    @rooms << Room.new("Rotting Stone Arch")
    @rooms << Room.new("Crumbling Clifftop")

    routes(@rooms, [
      [S, E], [E], [E], [S, E], [E], [E], [S, E], [S],
      [S], [S, E], [E], [], [E], [], [E], [S],
      [S], [S], [S, E], [E], [U, D], [S, E], [U, D], [S],
      [], [S], [S, E], [E], [E], [S], [S], [S],
      [S], [S, E], [S], [S], [S, U, D], [], [], [S],
      [E], [], [E], [], [S, E], [E], [], [S],
      [S, E], [N, S], [E], [E], [], [S], [S], [W],
      [E], [E], [E], [E], [E], [E], [E], []
    ])

    @current_room = @rooms[start_room]
    p = Parser.new(self)
    message = "Ok"

    while true
      @current_room.show(message)
      message = p.parse_input(gets)
    end
  end
end

HauntedHouse.new(57)