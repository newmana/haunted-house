class Ghosts
  def name
    ["GHOSTS"]
  end

  def vacuum(house)
    house.current_room.vacuum_ghosts
    "Whizz -- Vacuumed the ghosts up!"
  end
end