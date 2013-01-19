class Axe
  def name
    ["AXE"]
  end

  def swing(house)
    room = house.current_room
    if room.description.eql?("Study with a Desk and Hole in the Wall")
      room.description = "Study with a secret room."
      house.route(43, [Direction::W, Direction::N])
      "You broke the thin wall."
    else
      "Whoosh"
    end
  end
end