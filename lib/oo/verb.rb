class Verb
  def leave(room, object)
    room.add_object(object)
  end
end