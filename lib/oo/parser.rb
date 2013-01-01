require './lib/oo/go_command'
require './lib/oo/leave_command'
require './lib/oo/get_take_command'
require './lib/oo/help_command'
require './lib/oo/carrying_command'

class Parser
  def initialize(house)
    @house = house
    @go = GoCommand.new
    @commands = %w(HELP CARRYING? SCORE)
    @directions = @go.verbs
    @actions = %w(GET TAKE OPEN EXAMINE READ SAY DIG SWING CLIMB LIGHT UNLIGHT SPRAY USE UNLOCK LEAVE)
    @verbs = @commands + @directions + @actions
    @carrying = CarryingCommand.new
    @help = HelpCommand.new(@verbs)
    @leave = LeaveCommand.new
    @get_take = GetTakeCommand.new
  end

  def parse_input(input)
    verb, word = get_verb_word(input)
    valid_verb = @verbs.include?(verb)
    no_word = word.nil? && word.empty?
    valid_word = !no_word && @house.valid?(word)
    message = ""
    message = "I need two words" if no_word
    message = "You don't make sense" if !valid_verb
    message = "You can't '#{verb}'" if !valid_verb && valid_word
    message = "That's silly" if !valid_verb && !valid_word
    message = "You don't have #{word}" if valid_verb && valid_word && !@house.carrying?(word)
    if @help.verbs.include?(verb)
      @help.execute(verb, word, @house)
    elsif @carrying.verbs.include?(verb)
      @carrying.execute(verb, word, @house)
    elsif @go.verbs.include?(verb)
      message = @go.execute(verb, word, @house)
    elsif @leave.verbs.include?(verb)
      tmp_message = @leave.execute(verb, word, @house)
      message = tmp_message unless tmp_message.nil?
    elsif @get_take.verbs.include?(verb)
      message = @get_take.execute(verb, word, @house)
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