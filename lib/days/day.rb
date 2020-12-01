require_relative "one"

class Day
    def initialize(day_count)
        @day = day_count

        @specific_day = new_day(@day)
    end

    def get_solution
        "1: #{@specific_day.part_one} \n2: #{@specific_day.part_two}"
    end

    def new_day(day_class)
        Object.const_get(day_class).new
    end
end