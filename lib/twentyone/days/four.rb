# frozen_string_literal: true

module TwentyOne
  class Four
    def initialize
      input = File.readlines('./lib/twentyone/inputs/two.txt').map(&:chomp)
      @draw_numbers = input.first.split(',').map(&:to_i)
      @boards = []
      input.drop(2).each do |i|
        @boards << i
      end
    end

    def part_one
      ''
    end

    def part_two
      ''
    end

    private

    def multiply_final_value(depth, horizontal_distance)
      product = depth * horizontal_distance
      product.to_s
    end
  end
end
