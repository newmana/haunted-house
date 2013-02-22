Dir[File.dirname(__FILE__) + '/*.rb'].each do |file|
  require_relative './' + File.basename(file, File.extname(file))
end

module Oo
  module Command
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
        @open = OpenCommand.new
        @examine = ExamineCommand.new
        @read = ReadCommand.new
        @say = SayCommand.new
        @dig = DigCommand.new
        @swing = SwingCommand.new
        @climb = ClimbCommand.new
        @spray = SprayCommand.new
        @use = UseCommand.new
        @all_verbs = [@help, @carrying, @go, @leave, @get_take, @open, @examine, @read, @say, @dig, @swing, @climb, @spray,
          @use]
      end

      def parse_input(input)
        message, verb, word = validate(input)
        @all_verbs.each do |current_verb|
          if current_verb.verbs.include?(verb)
            tmp_message = current_verb.execute(verb, word, @house)
            message = tmp_message unless tmp_message.nil?
          end
        end
        message
      end

      def validate(input)
        verb, word = get_verb_word(input)
        valid_verb = @verbs.include?(verb)
        empty_word = !word.nil? && word.empty?
        has_word = !word.nil? && !word.empty?
        valid_word = has_word && @house.valid?(word)
        message = ""
        message = "I need two words" if empty_word
        message = "You don't make sense" if !valid_verb
        message = "You can't '#{verb} #{word}'" if !valid_verb && valid_word
        message = "That's silly" if valid_verb && has_word
        message = "You don't have #{word}" if valid_verb && valid_word && !@house.carrying?(word)
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
  end
end
