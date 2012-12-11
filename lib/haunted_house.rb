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

    @light_limit = 60

    @message = "Ok"
  end

  def show_location
    show_room
    show_objects
    puts "============================"
    puts @message
    @message = "What?"
    puts "What will you do now?"
    verb, word = get_verb_word(gets)
    candle
    vi, wi, @message = message(verb, word)
    display_help if vi == 0
    display_carrying if vi == 1
    movement(vi, wi) if (2..8).include?(vi)
  end

  def message(verb, word)
    vi = @verbs.index(verb)
    wi = @objects.index(word)
    message = "That's silly" if !vi.nil? && wi.nil? && !word.nil? && !word.empty?
    message = "I need two words" if !word.nil? && word.empty?
    message = "You don't make sense" if vi.nil? && wi.nil?
    message = "You can't '#{verb}'" if vi.nil? && !wi.nil?
    message = "You don't have #{word}" if !vi.nil? && vi > 8 && !wi.nil? && !@carrying[wi]
    message = "Your candle is waning!" if @light_limit == 10
    message = "Your candle is out" if @light_limit == 0
    return vi, wi, message
  end

  def candle
    if @flags[0]
      @light_limit -= 1
    end
    flags[0] = false if @light_limit < 1
  end

  def display_help
    display_list("Words I know:", @verbs)
  end

  def display_carrying
    display_list("You are carrying:", @carrying)
  end

  def display_list(message, list)
    puts "#{message}"
    @verbs.each_with_index do |v, index|
      print "#{v}"
      print "," if index < @verbs.length - 1
    end
    puts "\nPress enter to continue"
    gets
  end

  def movement(vi, wi)
    direction = 0
    direction = vi - 2 if wi.nil?
    direction = wi - 17 if !vi.nil? && vi == 2
    direction = 1 if direction == 5 && @room == 20
    direction = 3 if direction == 6 && @room == 20
    direction = 3 if direction == 5 && @room == 22
    direction = 2 if direction == 6 && @room == 22
    direction = 2 if direction == 5 && @room == 36
    direction = 1 if direction == 6 && @room == 36
    @routes[@room].chars.each do |c|
      @room -= 8 if c.eql?("N") && direction == 1
      @room += 8 if c.eql?("S") && direction == 2
      @room -= 1 if c.eql?("W") && direction == 3
      @room += 1 if c.eql?("E") && direction == 4
    end
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
    while true
      print "\e[2J\e[f"
      puts "Haunted House"
      puts "-------------"
      show_location
    end
  end
end
