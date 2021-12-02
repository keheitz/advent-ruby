# frozen_string_literal: true

class Nine
  def initialize
    @values = File.readlines('./lib/twenty/inputs/nine.txt').map(&:chomp).map(&:to_i)
    @PREAMBLE_LENTH = 25
  end

  def part_one
    @values.each_with_index do |val, i|
      next if i < @PREAMBLE_LENTH
      next if @values[i - @PREAMBLE_LENTH..i].combination(2).any? { |a, b| (a + b) == val }

      return val
    end
  end

  def part_two
    invalid_number = part_one
    @values.each_with_index do |_val, i|
      (1..i).each do |past|
        sum = @values[(i - past)..i].inject(:+)
        break if sum > invalid_number
        return @values[(i - past)..i].min + @values[(i - past)..i].max if sum == invalid_number
      end
    end
  end
end
