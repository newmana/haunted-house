module Direction
  N = :north
  S = :south
  W = :west
  E = :east
  U = :up
  D = :down

  def self.route(rooms, index, directions)
    directions.each do |d|
      direction, opposite =
        case d
          when N then [-8, S]
          when S then [8, N]
          when W then [-1, E]
          when E then [1, W]
          when U
            case index
              when 20 then [8, D]
              when 22 then [-1, D]
              when 36 then [-8, D]
            end
          when D
            case index
              when 20 then [-8, D]
              when 22 then [1, D]
              when 36 then [8, D]
            end
        end
      rooms[index].routes.store(d, rooms[index + direction])
      rooms[index + direction].routes.store(opposite, rooms[index])
    end
  end

  def self.routes(rooms, all_directions)
    all_directions.each.with_index do |d, i|
      Direction.route(rooms, i, d)
    end
  end
end