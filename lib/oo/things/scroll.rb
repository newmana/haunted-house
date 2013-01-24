class Scroll
  def name
    ["SCROLL"]
  end

  def examine
    examine_or_read
  end

  def read
    examine_or_read
  end

  def examine_or_read
    "The script is in an alien tongue."
  end
end