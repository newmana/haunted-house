class Parser
  def initialize(inventory)
    @inventory = inventory
    @commands = %w(HELP CARRYING? SCORE)
    @directions = %w(GO N S W E U D)
    @actions = %w(GET TAKE OPEN EXAMINE READ SAY DIG SWING CLIMB LIGHT UNLIGHT SPRAY USE UNLOCK LEAVE)
    @verbs = @commands + @directions + @actions
  end

  def parse_input(input)
    verb, word = get_verb_word(input)
    valid_verb = @verbs.include?(verb)
    no_word = word.nil? && word.empty?
    valid_word = !no_word && @inventory.valid?(word)
    message = ""
    messsage = "I need two words" if no_word
    messsage = "You don't make sense" if !valid_verb
    messsage = "You can't '#{verb}'" if !valid_verb && valid_word
    messsage = "That's silly" if !valid_verb && !valid_word
    messsage = "You don't have #{word}" if valid_verb && valid_word && !@inventory.carrying?(word)
    return message, verb, word
  end

  private

  def get_verb_word(input)
    if input.length > 0
      input = input.split
      input.map! { |q| q.strip.upcase }
      verb = input[0]
      word = ""
      if input.length > 1
        input.shift
        word = input.join(' ')
      end
      return verb, word
    end
    return "", ""
  end
end