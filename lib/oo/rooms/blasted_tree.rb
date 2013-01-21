class BlastedTree < Room

  def initialize(description, things=[], objects=[])
    super(description, things, objects)
    @up = false
  end

  def swing_rope
    "This is no time to play games."
  end

  def climb
    message = @up ? "Going down!" : "You see a thick forest and a cliff south."
    @up = !@up
    message
  end

  def go_direction(verb)
    if @up
      @up = false
      "Crash! You fell out of a tree!"
    else
      super(verb)
    end
  end
end