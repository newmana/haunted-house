class DeskDrawer

  def name
    ["DRAWER", "DESK"]
  end

  def open
    ["Drawer open.", Oo::Inventory::CANDLE]
  end

  def examine
    ["There is a drawer.", nil]
  end
end