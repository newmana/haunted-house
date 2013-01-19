class Rope
  def name
    ["ROPE"]
  end

  def swing(house)
    if house.current_room.description.eql?("Blasted Tree")
      "This is no time to play games."
    else
      "You swung it"
    end
  end
end