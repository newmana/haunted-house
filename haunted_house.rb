class HauntedHouse
  def initialize
    @location = 57

    @verbs = [
        "HELP", "CARRYING?", "GO", "N", "S", "W", "E", "U", "D", "GET", "TAKE", "OPEN", "EXAMINE", "READ", "SAY",
        "DIG", "SWING", "ClIMB", "LIGHT", "UNLIGHT", "SPRAY", "USE", "UNLOCK", "LEAVE", "SCORE"
    ]
    @directions = [
        "SE", "WE", "WE", "SWE", "WE", "WE", "SWE", "WS",
        "NS", "SE", "WE", "NW", "SE", "W", "NE", "NSW",
        "NS", "NS", "SE", "WE", "NWUD", "SE", "WSUD", "NS",
        "N", "NS", "NSE", "WE", "WE", "NSW", "NS", "NS",
        "S", "NSE", "NSW", "S", "NSUD", "N", "N", "NS",
        "NE", "NW", "NE", "W", "NSE", "WE", "W", "NS",
        "SE", "NSW", "E", "WE", "NW", "S", "SW", "NW",
        "NE", "NWE", "WE", "WE", "WE", "NWE", "NWE", "W"
    ]

    @objects = [
        "Painting", "Ring", "Magic Spells", "Goblet", "Scroll", "Coins", "Statue", "Candelstick",
        "Matches", "Vacuum", "Batteries", "Shovel", "Axe", "Rope", "Boat", "Aerosol", "Candle", "Key",
        "North", "South", "West", "East", "Up", "Down",
        "Doors", "Bats", "Ghosts", "Drawer", "Desk", "Cost", "Rubbish",
        "Coffin", "Books", "Xzanfar", "Wall", "Spells"
    ]

    @rooms = [
        "Dark Corner", "Overgrown Garden", "By a Large Wood Pile", "Yard by Rubbish",
        "Weed Patch", "Forest", "Thick Forest", "Blasted Tree",
        "Corner of the House", "Entrance to the Kitchen", "Kitchen and Grimy Cooker", "Scullery Door",
        "Room with Inches of Dust", "Rest Turret Room", "Clearing by House", "Path",
        "Side of the House", "Back of the Hallway", "Dark Alcove", "Small Dark Room",
        "Bottom of a Spiral Staircase", "Wide Passage", "Slippery Steps", "Clifftop",
        "Near a Crumbling Wall", "Gloomy Passage", "Pool of Light", "Impressive Vaulted Hallway",
        "Hall by a Thick Wooden Door", "Trophy Room", "Cellar with Barred Window", "Cliff Path",
        "Cupboard with Hanging Coat", "Front Hall", "Sitting Room", "Secret Room",
        "Steep Marble Stairs", "Dining Room",  "Deep Cellar with a Coffin", "Cliff Path",
        "Closet", "Front Lobby", "Library of Evil Books", "Study with a Desk and Hole in the Wall",
        "Weird Cobwebby Room", "Very Cold Chamber", "Spooky Room", "Cliff Path by the Marsh",
        "Rubble-Strewn Verandah", "Front Porch", "Front Tower", "Sloping Corridor",
        "Upper Gallery", "Marsh by a Wall", "Marsh", "Soggy Path by a Twisted Railing",
        "Path through an Iron Gate", "By Railings", "Beneath the Front Tower",
        "Debris from Crumbling Facade", "Large Fallen Brick Work", "Rotting Stone Arch", "Crumbling Clifftop"
    ]
  end

  def welcome
    puts "Haunted House"
    puts "-------------"
    puts "Your location: #{@rooms[@location]}"
    print "Exits: "
    @directions[@location].chars.each_with_index do |c, index|
      print "#{c}"
      print "," if index < (@directions[@location].length - 1)
    end
    STDOUT.flush
    puts
  end
end

h = HauntedHouse.new
h.welcome