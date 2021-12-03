# frozen_string_literal: true

module TwentyOne
  class Two
    def initialize
      input = File.readlines('./lib/twentyone/inputs/two.txt').map(&:chomp)
      @submarine_commands = input.map do |i|
        {
          direction: i.split(' ')[0],
          amount: i.split(' ')[1].to_i
        }
      end
    end

    def part_one
      depth = 0
      horizontal_distance = 0
      @submarine_commands.each do |command|
        depth, horizontal_distance = calculate_path_original(command, depth, horizontal_distance)
      end
      multiply_final_value(depth, horizontal_distance)
    end

    def part_two
      aim = 0
      depth = 0
      horizontal_distance = 0
      @submarine_commands.each do |command|
        depth, horizontal_distance, aim = calculate_path_revised(command, depth, horizontal_distance, aim)
      end
      multiply_final_value(depth, horizontal_distance)
    end

    private

    def multiply_final_value(depth, horizontal_distance)
      product = depth * horizontal_distance
      product.to_s
    end

    def calculate_path_original(command, depth, horizontal_distance)
      case command[:direction]
      when 'up'
        depth -= command[:amount]
      when 'down'
        depth += command[:amount]
      when 'forward'
        horizontal_distance += command[:amount]
      else
        puts "Not a known command direction - #{command[:direction]} #{command[:amount]}"
      end
      [depth, horizontal_distance]
    end

    def calculate_path_revised(command, depth, horizontal_distance, aim)
      case command[:direction]
      when 'up'
        aim -= command[:amount]
      when 'down'
        aim += command[:amount]
      when 'forward'
        depth += command[:amount] * aim
        horizontal_distance += command[:amount]
      else
        puts "Not a known command direction - #{command[:direction]} #{command[:amount]}"
      end
      [depth, horizontal_distance, aim]
    end
  end
end
