class Room
  attr_accessor :routes, :description, :objects

  def initialize(description, *objects)
    @routes = {}
    @description = description
    @objects = objects
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