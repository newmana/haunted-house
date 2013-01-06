class Books
  def name
    ["BOOKS"]
  end

  def examine
    examine_or_read
  end

  def read
    examine_or_read
  end

  def examine_or_read
    ["They are demonic works.", nil]
  end
end