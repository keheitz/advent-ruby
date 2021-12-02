# frozen_string_literal: true

module TwentyOne
  class One
    def part_one
      consecutive_inc_count(parse_inputs)
    end

    def part_two
      consecutive_inc_count(three_measurement_sliding_window(parse_inputs))
    end

    private

    def consecutive_inc_count(depths)
      depths.each_cons(2).map { |a, b| b - a }.count(&:positive?)
    end

    def three_measurement_sliding_window(inputs)
      inputs.each_cons(3).map { |a, b, c| a + b + c }
    end

    def parse_inputs
      File.readlines('./lib/twentyone/inputs/one.txt').map(&:chomp).map(&:to_i)
    end
  end
end
