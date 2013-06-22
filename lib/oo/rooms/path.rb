class Path < Room

  def initialize(rooms, description, things=[], objects=[])
    super(rooms, description, things, objects)
  end

  def score(has_boat, score)
    puts "Double score for reaching here!"
    score * 2
  end
end