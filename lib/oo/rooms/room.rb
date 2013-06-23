class Room
  attr_accessor :routes, :description, :objects, :words

  def initialize(inventory, rooms, description, things=[], objects=[])
    @inventory = inventory
    @rooms = rooms
    @routes = {}
    @description = description
    @words = {}
    things.each do |thing|
      thing.name.each do |name|
        @words[name] = thing
      end
    end
    @objects = objects
    @rooms << self
  end

  def magic_occurs
    @rooms.room(Random.new.rand(64))
  end

  def swing_rope
    "You swung it"
  end

  def swing_axe
    "Whoosh"
  end

  def dig_shovel
    "You've made a hole."
  end

  def climb
  end

  def bats
    false
  end

  def ghosts
    false
  end

  def unlock_door
  end

  def stop_boat
    @inventory.carrying?(Oo::Things::BOAT)
  end

  def score(has_boat, score)
    puts "You have everything.\nReturn to the gate to get the final score" if !has_boat
    score
  end

  def go_direction(verb)
    if stop_boat
      ["You can't carry a boat!", self]
    else
      if routes.keys.include?(verb)
        return ["Ok", routes[verb]]
      end
      ["You can't go that way!", self]
    end
  end

  def routes_to_s
    @routes.keys.map { |k| k.to_s }.join(",")
  end

  def show(message)
    RUBY_PLATFORM.downcase.include?("mswin") ? system("cls") : system("clear")
    puts "Haunted House"
    puts "-------------"
    puts "Your location: #{description}"
    print "Exits: "
    print routes_to_s
    STDOUT.flush
    puts
    @objects.each do |object|
      puts "You can see #{object.to_s.gsub("_", " ")}"
    end
    puts "============================"
    puts message
    puts "What will you do now?"
  end
end