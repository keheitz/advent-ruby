require_relative "one"
require_relative "two"
require_relative "three"
require_relative "four"
require_relative "five"
require_relative "six"
require_relative "seven"
require_relative "eight"
require_relative "nine"
require_relative "ten"

class Day
    def initialize(day_count)
        @day = day_count

        @specific_day = new_day(@day)
    rescue 
        puts "You requested a day that hasn't been solved (yet)"
    end

    def get_solution
        if @specific_day.nil?
            "sorry..."
        else
            "1: #{@specific_day.part_one} \n2: #{@specific_day.part_two}"
        end
    end

    def new_day(day_class)
        Object.const_get(day_class).new
    end
end