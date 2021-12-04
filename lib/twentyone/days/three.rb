# frozen_string_literal: true

module TwentyOne
  class Three
    def initialize
      # something is wrong, this creates a 2d array of values but an extra '0' is appended to each
      @input = File.readlines('./lib/twentyone/inputs/three.txt').map do |line|
        line.split('').map(&:to_i)
      end
    end

    def part_one
      gamma_rate = []
      epsilon_rate =  []
      (0..11).each do |column|
        zeroes = @input.map { |line| line[column] }.count(0)
        ones = @input.map { |line| line[column] }.count(1)
        build_gamma_and_epsilon_rates(zeroes > ones, gamma_rate, epsilon_rate)
      end
      gamma = convert_binary_to_digit(gamma_rate)
      epsilon = convert_binary_to_digit(epsilon_rate) 
      gamma * epsilon
    end

    def part_two
      o2_generator = convert_binary_to_digit(filter_binary_values(true)[0].first(12))
      c02_scrubber_rating = convert_binary_to_digit(filter_binary_values(false)[0].first(12))
      o2_generator * c02_scrubber_rating
    end

    private

    def convert_binary_to_digit(binary_value)
      binary_value.join.to_i(2)
    end

    def build_gamma_and_epsilon_rates(zeroes_greater, gamma_rate, epsilon_rate)
      if zeroes_greater
        gamma_rate << 0
        epsilon_rate << 1
      else
        gamma_rate << 1
        epsilon_rate << 0
      end
    end

    def select_matching_values(values, column, bit)
      values.select { |val| val[column] == bit }
    end

    def filter_binary_values(most_common_bit)
      values = @input.dup
      (0..11).each do |column|
        bit_criteria = most_common_bit ? 1 : 0
        zeroes = values.map { |line| line[column] }.count(0)
        ones = values.map { |line| line[column] }.count(1)
        if zeroes > ones
          bit_criteria = most_common_bit ? 0 : 1
        end
        values = select_matching_values(values, column, bit_criteria)
        break if values.count == 1
      end
      values
    end
  end
end
