class Shovel
  def name
    ["SHOVEL"]
  end

  def dig(house)
    room = house.current_room
    if room.description.eql?("Cellar with Barred Window")
      room.description = "Hole in the wall."
      house.route(30, [Direction::N, Direction::S, Direction::E])
      "Dug the bars out."
    else
      "You've made a hole."
    end
  end
end