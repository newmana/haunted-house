module Oo
  module Command
    module DisplayList
      def display_list(message, list)
        puts "#{message}"
        list.each_with_index do |v, index|
          print "#{v}"
          print "," if index < list.length - 1
        end
        press_enter_to_continue
      end
    end
  end
end
