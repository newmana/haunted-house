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
end