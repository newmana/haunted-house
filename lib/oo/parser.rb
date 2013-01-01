require './lib/oo/go_command'

class Parser
  def initialize(house)
    @house = house
    @go = GoCommand.new
    @commands = %w(HELP CARRYING? SCORE)
    @directions = @go.verbs
    @actions = %w(GET TAKE OPEN EXAMINE READ SAY DIG SWING CLIMB LIGHT UNLIGHT SPRAY USE UNLOCK LEAVE)
    @verbs = @commands + @directions + @actions
  end

  def parse_input(input)
    verb, word = get_verb_word(input)
    valid_verb = @verbs.include?(verb)
    no_word = word.nil? && word.empty?
    valid_word = !no_word && @house.valid?(word)
    message = ""
    messsage = "I need two words" if no_word
    messsage = "You don't make sense" if !valid_verb
    messsage = "You can't '#{verb}'" if !valid_verb && valid_word
    messsage = "That's silly" if !valid_verb && !valid_word
    messsage = "You don't have #{word}" if valid_verb && valid_word && !@house.carrying?(word)
    if @go.verbs.include?(verb)
      @house.current_room = @go.execute(verb, word, @house.current_room)
    end
    message
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