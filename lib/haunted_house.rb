class HauntedHouse
  @@default_flags = Array.new(36).each_with_index.map {|x, i| [18,17,2,26,28,23].include?(i)}

  attr_reader :objects, :descriptions, :message, :flags

  def self.default_flags
    @@default_flags
  end

  def initialize(start_room, flags, carrying)
    @room = start_room

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
        "Hall by a Thick Wooden Doors", "Trophy Room", "Cellar with Barred Window", "Cliff Path",
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
        "Doors", "Bats", "Ghosts", "Drawer", "Desk", "Coat", "Rubbish",
        "Coffin", "Books", "Xzanfar", "Wall", "Spells"
    ]

    # Locations for gettable objects
    @locations = [
        46, 38, 35, 50, 13, 18, 28, 42, 10, 25, 26, 4, 2, 7, 47, 60, 43, 32
    ]

    @flags = flags.dup
    @carrying = carrying
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
    vi, wi, @message = get_message(verb, word)
    display_help if vi == 0
    display_carrying if vi == 1
    if (2..8).include?(vi)
      move(vi, wi)
    end
    get_take(wi) if !wi.nil? && vi == 9 || vi == 10
    open(wi) if vi == 11
    examine(wi) if vi == 12
    read(wi) if vi == 13
    say(word, wi) if vi == 14
    dig if vi == 15
    swing(wi) if vi == 16
    climb if vi == 17
    light(wi) if vi == 18
    unlight if vi == 19
    spray(wi) if vi == 20
    use(wi) if vi == 21
    unlock(wi) if vi == 22
    leave(wi) if vi == 23
    score if vi == 24
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

  def candle
    if @flags[0]
      @light_limit -= 1
    end
    flags[0] = false if @light_limit < 1
  end

  def get_message(verb, word)
    vi = @verbs.index(verb)
    wi = @objects.index(word)
    message = "That's silly" if !vi.nil? && wi.nil? && !word.nil? && !word.empty?
    message = "I need two words" if !word.nil? && word.empty?
    message = "You don't make sense" if vi.nil? && wi.nil?
    message = "You can't '#{verb}'" if vi.nil? && !wi.nil?
    message = "You don't have #{word}" if !vi.nil? && !wi.nil? && wi > 0 && vi > 8 && !@carrying[wi]
    message = "Your candle is waning!" if @light_limit == 10
    message = "Your candle is out" if @light_limit == 0
    return vi, wi, message
  end

  def display_help
    display_list("Words I know:", @verbs)
  end

  def display_carrying
    display_list("You are carrying:", create_carrying(@carrying, @objects))
  end

  def create_carrying(carrying, all_objects)
    index = -1
    objects = carrying.map do |c|
      index += 1
      c ? index : -1
    end
    objects.select { |c| !c.nil? && c > 0 }.map { |c| all_objects[c] }
  end

  def display_list(message, list)
    puts "#{message}"
    list.each_with_index do |v, index|
      print "#{v}"
      print "," if index < list.length - 1
    end
    press_enter_to_continue
  end

  def move(vi, wi)
    if @flags[14]
      @flags[14] = false
      @message = "Crash! You fell out of a tree!"
    elsif @flags[27] && @room == 52
      @message = "Ghosts will not let you move."
    elsif @room == 45 && @carrying[1] && !@flags[34]
      @message = "A magical barrier to the west."
    elsif @room == 54 && !@carrying[15]
      @message = "You're stuck!"
    elsif @carrying[15] and !([53, 54, 55, 57].include?(@room))
      @message = "You can't carry a boat!"
    elsif (26..30).include?(@room) && @flags[0]
      @message = "Too dark to move."
    elsif vi == 2 && wi.nil?
      @message = "Go where?"
    else
      change = movement(vi, wi)
      if change != 0
        @room += change
        if @room == 41 && @flags[23]
          @routes[49] = "SW"
          @message = "The door slams shut!"
          @flags[23] = false
        end
      else
        @message = "Can't go that way!"
      end
    end
  end

  def movement(vi, wi)
    change = 0
    direction = 0
    direction = vi - 2 if wi.nil?
    direction = wi - 17 if !vi.nil? && vi == 2
    direction = 1 if direction == 5 && @room == 20
    direction = 3 if direction == 6 && @room == 20
    direction = 3 if direction == 5 && @room == 22
    direction = 2 if direction == 6 && @room == 22
    direction = 2 if direction == 5 && @room == 36
    direction = 1 if direction == 6 && @room == 36
    if (@room == 26 && !@flags[0]) && (direction == 1 || direction == 4)
      @message = "You need a light."
    else
      @routes[@room].chars.each do |c|
        change = -8 if c.eql?("N") && direction == 1
        change = 8 if c.eql?("S") && direction == 2
        change = -1 if c.eql?("W") && direction == 3
        change = 1 if c.eql?("E") && direction == 4
      end
    end
    change
  end

  def get_take(wi)
    if wi >= 18
      @message = "I can't get #{@objects[wi]}"
    else
      @message = "It isn't here" if @locations[wi] != @room
      @message = "What #{@objects[wi]}?" if @flags[wi]
      @message = "You already have it" if @carrying[wi]
      if wi >= 0 && wi < 18 && @locations[wi] == @room && !@flags[wi]
        @carrying[wi] = true
        @locations[wi] = 65
        @message = "You have the #{@objects[wi]}"
      end
    end
  end

  def open(wi)
    if @room == 43 && (wi == 27 || wi == 28)
      @flags[17] = false
      @message = "Drawer open"
    elsif @room == 28 and wi == 24
      @message = "It's locked"
    elsif @room == 38 and wi == 31
      @message = "That's creepy!"
      @flags[2] = false
    end
  end

  def examine(wi)
    @message = "There is a drawer" if wi == 27 || wi == 28
    if wi == 29
      @flags[18] = false
      @message = "Something here!"
    end
    @message = "That's disgusting!" if wi == 30
    open(wi) if wi == 31
    read(wi) if wi == 32 || wi == 4
    @message = "There's something beyond" if @room == 43 && wi == 34
  end

  def read(wi)
    @message = "They are demonic works." if @room == 42 && wi == 32
    @message = "Use this word with care 'Xzanfar'." if (wi == 2 || wi == 35) && @carrying[2] && !@flags[33]
    @message = "The script is in an alien tongue." if @carrying[0] && wi == 4
  end

  def say(word, wi)
    @message = "Ok #{word}"
    if @carrying[3] && wi == 33
      @message = "*Magic Occurs*"
      if @room == 45
        @flags[33] = true
      else
        @room = Random.new(64) - 1
      end
    end
  end

  def dig
    if @carrying[12]
      if @room == 30
        @message = "Dug the bars out."
        @descriptions[@room] = "Hole in the wall."
        @routes[@room] = "NSE"
      else
        @message = "You've made a hole."
      end
    end
  end

  def swing(wi)
    @message = "This is no time to play games." if @carrying[14] && @room == 7
    @message = "You swung it" if wi == 13 && @carrying[14]
    if wi == 12 && @carrying[13]
      if @room == 43
        @descriptions[@room] = "Study with a secret room."
        @routes[@room] = "WN"
        @message = "You broke the thin wall."
      else
        @message = "Whoosh"
      end
    end
  end

  def climb
    if wi == 13
      if @carrying[14]
        @message = "It isn't attached to anything!"
      elsif !@carrying[14] && @room == 7
        if @flags[13]
          @message = "Going down."
          @flags[13] = false
        else
          @message = "You see a thick forest and a cliff south."
          @flags[13] = true
        end
      end
    end
  end

  def light(wi)
    if wi == 16
      if @carrying[17]
        @message = "It will burn your hands." if !@carrying[8]
        @message = "Nothing to light it with." if !@carrying[9]
        if @carrying[8] && @carrying[9]
          @message = "It casts a flickering light."
          @flags[0] = true
        end
      end
    end
  end

  def unlight
    if @flags[0]
      @flags[0] = false
      @message = "Extinguished."
    end
  end

  def spray(wi)
    if wi == 25 && @carrying[15]
      if @flags[26]
        @flags[26] = false
        @message = "Pfft! Got them."
      else
        @message = "Hissss"
      end
    end
  end

  def use(wi)
    if wi == 9 and @carrying[9] & @carrying[10]
      @message = "Switched on."
      @flags[24] = true
    end
    if @flags[27] && @flags[24]
      @message = "Whizz -- Vacuumed the ghosts up!"
      @flags[27] = false
    end
  end

  def unlock(wi)
    open(wi) if @room == 42 && (wi == 26 || wi == 27)
    if @room == 27 && wi == 24 && !@flags[24] && @carrying[17]
      @flags[24] = true
      @routes[@room] = "SEW"
      @descriptions[@room] = "Huge open door."
      @message = "The key turns!"
    end
  end

  def leave(wi)
    if @carrying[wi]
      @carrying[wi] = false
      @locations[wi] = @room
      @message = "Done."
    end
  end

  def score
    score = @carrying.reduce(0) { |sum, value| value.nil? ? sum : sum += 1 }
    if score == 17
      if @carrying[14] && room != 56
        puts "You have everything.\nReturn to the gate to get the final score"
      elsif room == 57
        puts "Double score for reaching here!"
        score *= 2
      end
    end
    puts "Your score #{score}"
    puts "Well done! You finished the game." if score > 18
    press_enter_to_continue
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

  def press_enter_to_continue
    puts "\nPress enter to continue"
    gets
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
