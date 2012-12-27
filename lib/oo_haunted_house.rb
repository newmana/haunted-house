require './lib/an_object'
require './lib/room'

class OoHauntedHouse
  def initialize
    Room.new("SE", "Dark Corner")
    Room.new("WE", "Overgrown Garden")
    Room.new("WE", "By a Large Wood Pile", [AnObject.new("AXE")])
    Room.new("SWE", "Yard by Rubbish")
    Room.new("WE", "Weed Patch", [AnObject.new("SHOVEL")])
    Room.new("WE", "Forest")
    Room.new("SWE", "Thick Forest")
    Room.new("WS", "Blasted Tree", [AnObject.new("ROPE")])

    Room.new("NS", "Corner of the House")
    Room.new("SE", "Entrance to the Kitchen")
    Room.new("WE", "Kitchen and Grimy Cooker", [AnObject.new("MATCHES")])
    Room.new("NW", "Scullery Door")
    Room.new("SE", "Room with Inches of Dust")
    Room.new("W", "Rear Turret Room", [AnObject.new("SCROLL")])
    Room.new("NE", "Clearing by House")
    Room.new("NSW", "Path")

    Room.new("NS", "Side of the House")
    Room.new("NS", "Back of the Hallway")
    Room.new("SE", "Dark Alcove", AnObject.new("COINS"))
    Room.new("WE", "Small Dark Room")
    Room.new("NWUD", "Bottom of a Spiral Staircase")
    Room.new("SE", "Wide Passage")
    Room.new("WSUD" , "Slippery Steps")
    Room.new("NS", "Clifftop")

    Room.new("N", "Near a Crumbling Wall")
    Room.new("NS", "Gloomy Passage", [AnObject.new("VACUUM")])
    Room.new("NSE", "Pool of Light", [AnObject.new("BATTERIES")])
    Room.new("WE", "Impressive Vaulted Hallway")
    Room.new("WE", "Hall by a Thick Wooden Door", [AnObject.new("STATUE")])
    Room.new("NSW", "Trophy Room")
    Room.new("NS", "Cellar with Barred Window")
    Room.new("NS", "Cliff Path")

    Room.new("S", "Cupboard with Hanging Coat", [AnObject.new("KEY")])
    Room.new("NSE", "Front Hall")
    Room.new("NSW", "Sitting Room")
    Room.new("S", "Secret Room", [AnObject.new("MAGIC SPELLS")])
    Room.new("NSUD", "Steep Marble Stairs")
    Room.new("N", "Dining Room")
    Room.new("N", "Deep Cellar with a Coffin", [AnObject.new("RING")])
    Room.new("NS", "Cliff Path")

    Room.new("NE", "Closet")
    Room.new("NW", "Front Lobby")
    Room.new("NE", "Library of Evil Books", [AnObject.new("CANDLESTICK")])
    Room.new("W", "Study with a Desk and Hole in the Wall", [AnObject.new("CANDLE")])
    Room.new("NSE", "Weird Cobwebby Room")
    Room.new("WE", "Very Cold Chamber")
    Room.new("W", "Spooky Room", [AnObject.new("PAINTING")])
    Room.new("NS", "Cliff Path by the Marsh", [AnObject.new("BOAT")])

    Room.new("SE", "Rubble-Strewn Verandah")
    Room.new("NSW", "Front Porch")
    Room.new("E", "Front Tower", [AnObject.new("GOBLET")])
    Room.new("WE", "Sloping Corridor")
    Room.new("NW", "Upper Gallery")
    Room.new("S", "Marsh by a Wall")
    Room.new("SW", "Marsh")
    Room.new("NW", "Soggy Path")

    Room.new("NE", "By a Twisted Railing")
    Room.new("NWE", "Path through an Iron Gate")
    Room.new("WE", "By Railings")
    Room.new("WE", "Beneath the Front Tower")
    Room.new("WE", "Debris from Crumbling Facade", [AnObject.new("AEROSOL")])
    Room.new("NWE", "Large Fallen Brick Work")
    Room.new("NWE", "Rotting Stone Arch")
    Room.new("W", "Crumbling Clifftop")
  end
end

OoHauntedHouse.new