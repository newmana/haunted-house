class DeskDrawer

  def name
    ["DRAWER", "DESK"]
  end

  def unlock
    unlock_or_open
  end

  def open
    unlock_or_open
  end

  def examine
    ["There is a drawer.", nil]
  end

  def unlock_or_open
    ["Drawer open.", Oo::Things::CANDLE]
  end
end