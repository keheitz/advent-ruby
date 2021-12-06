# frozen_string_literal: true

require_relative 'one'
require_relative 'two'
require_relative 'three'
require_relative 'four'
require_relative 'five'
require_relative 'six'

module TwentyOne
  class Day
    def initialize(day_count)
      @day = day_count

      @specific_day = new_day(@day)
    rescue StandardError => e
      pp e
      puts "You requested a day that hasn't been solved (yet)"
    end

    def solution
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
