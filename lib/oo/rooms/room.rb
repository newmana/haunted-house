class Room
  attr_accessor :routes, :description, :objects, :words

  def initialize(rooms, description, things=[], objects=[])
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

  def go_direction(verb)
    if routes.keys.include?(verb)
      return ["Ok", routes[verb]]
    end
    ["You can't go that way!", self]
  end

  def show(message)
    if RUBY_PLATFORM.downcase.include?("mswin")
      system("cls")
    else
      system("clear")
    end
    puts "Haunted House"
    puts "-------------"
    puts "Your location: #{description}"
    print "Exits: "
    @routes.keys.each.with_index do |k, index|
      print "#{k.to_s}"
      print "," if index < (@routes.keys.length - 1)
    end
    STDOUT.flush
    puts
    @objects.each do |object|
      puts "You can see #{object.to_s}"
    end
    puts "============================"
    puts message
    puts "What will you do now?"
  end
end