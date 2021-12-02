# frozen_string_literal: true

require_relative 'one'

module TwentyOne
  class Day
    def initialize(day_count)
      @day = day_count

      @specific_day = new_day(@day)
    rescue StandardError => e
      pp e
      puts "You requested a day that hasn't been solved (yet)"
    end

    def get_solution
      if @specific_day.nil?
        'sorry...'
      else
        "1: #{@specific_day.part_one} \n2: #{@specific_day.part_two}"
      end
    end

    def new_day(day_class)
      Object.const_get("TwentyOne::#{day_class}").new
    end
  end
end