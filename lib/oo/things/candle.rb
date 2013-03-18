class Candle

  def initialize
    @lit = false
  end

  def name
    ["CANDLE"]
  end

  def is_lit?
    @lit
  end

  def set_lit
    @lit = true
  end

  def light(house)
    return "Nothing to light it with." unless house.carrying?(Oo::Inventory::MATCHES)
    return "It will burn your hands." unless house.carrying?(Oo::Inventory::CANDLESTICK)
    set_lit
    "It casts a flickering light."
  end

  def unlight
    if @lit
      @lit = false
      "Extinguished."
    end
  end
end