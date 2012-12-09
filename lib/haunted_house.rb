class HauntedHouse
  def initialize
    @room = 57

    @verbs = [
        "HELP", "CARRYING?", "GO", "N", "S", "W", "E", "U", "D", "GET", "TAKE", "OPEN", "EXAMINE", "READ", "SAY",
        "DIG", "SWING", "ClIMB", "LIGHT", "UNLIGHT", "SPRAY", "USE", "UNLOCK", "LEAVE", "SCORE"
    ]

    @routes = [
        "SE", "WE", "WE", "SWE", "WE", "WE", "SWE", "WS",
        "NS", "SE", "WE", "NW", "SE", "W", "NE", "NSW",
        "NS", "NS", "SE", "WE", "NWUD", "SE", "WSUD", "NS",
        "N", "NS", "NSE", "WE", "WE", "NSW", "NS", "NS",
        "S", "NSE", "NSW", "S", "NSUD", "N", "N", "NS",
        "NE", "NW", "NE", "W", "NSE", "WE", "W", "NS",
        "SE", "NSW", "E", "WE", "NW", "S", "SW", "NW",
        "NE", "NWE", "WE", "WE", "WE", "NWE", "NWE", "W"
    ]

    @descriptions = [
        "Dark Corner", "Overgrown Garden", "By a Large Wood Pile", "Yard by Rubbish",
        "Weed Patch", "Forest", "Thick Forest", "Blasted Tree",
        "Corner of the House", "Entrance to the Kitchen", "Kitchen and Grimy Cooker", "Scullery Door",
        "Room with Inches of Dust", "Rear Turret Room", "Clearing by House", "Path",
        "Side of the House", "Back of the Hallway", "Dark Alcove", "Small Dark Room",
        "Bottom of a Spiral Staircase", "Wide Passage", "Slippery Steps", "Clifftop",
        "Near a Crumbling Wall", "Gloomy Passage", "Pool of Light", "Impressive Vaulted Hallway",
        "Hall by a Thick Wooden Door", "Trophy Room", "Cellar with Barred Window", "Cliff Path",
        "Cupboard with Hanging Coat", "Front Hall", "Sitting Room", "Secret Room",
        "Steep Marble Stairs", "Dining Room", "Deep Cellar with a Coffin", "Cliff Path",
        "Closet", "Front Lobby", "Library of Evil Books", "Study with a Desk and Hole in the Wall",
        "Weird Cobwebby Room", "Very Cold Chamber", "Spooky Room", "Cliff Path by the Marsh",
        "Rubble-Strewn Verandah", "Front Porch", "Front Tower", "Sloping Corridor",
        "Upper Gallery", "Marsh by a Wall", "Marsh", "Soggy Path",
        "By a Twisted Railing", "Path through an Iron Gate", "By Railings", "Beneath the Front Tower",
        "Debris from Crumbling Facade", "Large Fallen Brick Work", "Rotting Stone Arch", "Crumbling Clifftop"
    ]

    @objects = [
        "Painting", "Ring", "Magic Spells", "Goblet", "Scroll", "Coins", "Statue", "Candlestick",
        "Matches", "Vacuum", "Batteries", "Shovel", "Axe", "Rope", "Boat", "Aerosol", "Candle", "Key",
        "North", "South", "West", "East", "Up", "Down",
        "Doors", "Bats", "Ghosts", "Drawer", "Desk", "Cost", "Rubbish",
        "Coffin", "Books", "Xzanfar", "Wall", "Spells"
    ]

    # Locations for gettable objects
    @locations = [
        46, 38, 35, 50, 13, 18, 28, 42, 10, 25, 26, 4, 2, 7, 47, 60, 43, 32
    ]

    @flags = []
    @flags[18] = @flags[17] = @flags[2] = @flags[26] = @flags[28] = @flags[23] = true

    @carrying = []

    @message = "Ok"
  end

  def show_location
    show_room
    show_objects
    puts "============================"
    puts @message
    @message = "What"
    puts "What will you do now?"
    verb, word = get_verb_word(gets)
    vi, wi, message = find_verb_word(verb, word)
    display_help if vi == 0
    display_carrying if vi == 1
    movement(vi, wi) if (2..8).include?(vi)
  end

  def find_verb_word(verb, word)
    vi = @verbs.index(verb)
    wi = @objects.index(word)
    message = "That's silly" if !word.nil? && !word.empty? && wi.nil?
    return vi, wi, message
  end

  def display_help
    puts "Words I know:"
    @verbs.each_with_index do |v, index|
      print "#{v}"
      print "," if index < @verbs.length
    end
    puts
  end

  def display_carrying
    puts "You are carrying:"
    @carrying.each_with_index do |c, index|
      print "#{c}"
      print "," if index < @carrying.length
    end
  end

  def movement(vi, wi)
    direction = 0
    print "#{@verbs[vi]} #{@objects[wi]}"
  end

  def show_room
    puts "Your location: #{@descriptions[@room]}"
    print "Exits: "
    @routes[@room].chars.each_with_index do |c, index|
      print "#{c}"
      print "," if index < (@routes[@room].length - 1)
    end
    STDOUT.flush
    puts
  end

  def show_objects
    @locations.each_with_index do |l, i|
      puts "You can see #{@objects[i]}" if @locations[i] == @room && !@flags[i]
    end
  end

  def get_verb_word(question)
    if question.length > 0
      question = question.split
      verb = question[0]
      if question.length > 1
        question.shift
        word = question.join(' ')
      end
      verb.strip! unless verb.nil?
      verb.upcase! unless verb.nil?
      word.strip! unless word.nil?
      word.capitalize! unless word.nil?
      return verb, word
    end
    return "", ""
  end

  def welcome
    puts "Haunted House"
    puts "-------------"
    show_location
  end
end
