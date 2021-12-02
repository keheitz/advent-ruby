# frozen_string_literal: true

module TwentyOne
  class One
    def part_one
      'one'
    end

    def part_two
      '2'
    end

    def parse_inputs
      File.readlines('./lib/twenty/inputs/one.txt').map(&:chomp).map(&:to_i)
    end
  end
end
