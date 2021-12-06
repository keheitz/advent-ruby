# frozen_string_literal: true

module TwentyOne
  class Six
    def initialize
      @lanternfish = File.read('./lib/twentyone/inputs/six.txt').split(',').map(&:to_i)
    end

    def part_one
      lanternfish_model = @lanternfish.dup
      days = 80
      days.times do |_year|
        zero_count = lanternfish_model.count(0)
        lanternfish_model.map! { |fish| fish.zero? ? 6 : fish - 1 }
        zero_count.times do
          lanternfish_model << 8
        end
      end
      lanternfish_model.count
    end

    def part_two
      days = 256
      fish_counts = @lanternfish.group_by { |i| i }.transform_values(&:count)
      days.times do |_day|
        fish_counts = update_counts(fish_counts)
      end
      sum = sum_values(fish_counts)
      sum.to_s
    end

    private

    def update_counts(fish_counts)
      zero_count = fish_counts[0].nil? ? 0 : fish_counts[0]
      fish_counts.transform_keys! { |k| decrement_fish_timer(k) }
      fish_counts[8] = zero_count
      if fish_counts[6].nil?
        fish_counts[6] = zero_count
      else
        fish_counts[6] += zero_count
      end
      fish_counts
    end

    def sum_values(values)
      sum = 0
      values.each do |k, v|
        next if v.nil? || k.nil?

        sum += v
      end
      sum
    end

    def decrement_fish_timer(timer)
      return if timer.nil? || timer.zero?

      timer - 1
    end
  end
end
