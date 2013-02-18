class Coffin
  def name
    ["COFFIN"]
  end

  def open
    examine_or_open
  end

  def examine
    examine_or_open
  end

  def examine_or_open
    ["That's creepy!", Oo::Inventory::RING]
  end
end