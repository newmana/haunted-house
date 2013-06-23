class Candle < Thing

  def initialize
    @lit = false
    @light_left = 60
  end

  def is_lit?
    @lit
  end

  def set_lit
    @lit = true
  end

  def time
    burn
  end

  def burn
    @light_left -= 1 if @lit
    @lit = false if @light_left < 1
    return "Your candle is waning!\n" if @light_left == 10
    return "Your candle is out\n" if @light_left == 1
    ""
  end

  def light(house)
    return "Nothing to light it with." unless house.inventory.carrying?(Oo::Things::MATCHES)
    return "It will burn your hands." unless house.inventory.carrying?(Oo::Things::CANDLESTICK)
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