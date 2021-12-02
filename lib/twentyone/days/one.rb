# frozen_string_literal: true

class One
  def part_one
    multiply_values_equaling_2020
  end

  def part_two
    multiply_three_values_equaling_2020
  end

  def parse_inputs
    File.readlines('./lib/twenty/inputs/one.txt').map(&:chomp).map(&:to_i)
  end

  def multiply_values_equaling_2020
    parse_inputs.each_with_index do |value, i|
      parse_inputs.each_with_index do |other, j|
        next if i == j
        return value * other if value + other == 2020
      end
    end
    puts 'No correct answer found...'
    0
  end

  def multiply_three_values_equaling_2020
    parse_inputs.each_with_index do |value, i|
      parse_inputs.each_with_index do |other, j|
        parse_inputs.each_with_index do |third, k|
          next if i == j || i == k || j == k
          return value * other * third if value + other + third == 2020
        end
      end
    end
    puts 'No correct answer found...'
    0
  end
end
