# frozen_string_literal: true

class Five
  def initialize
    @lines = File.readlines('./lib/twenty/inputs/five.txt').map(&:chomp)
  end

  def part_one
    boarding_list.max_by { |i| i[:id] }[:id]
  end

  def part_two
    find_empty_seat
  end

  def boarding_list
    seat_ids = []
    @lines.each do |line|
      partition_chars = line.scan(/\w/)
      rows = [*0..127]
      seats = [*0..7]
      (0...7).each do |partition|
        rows = partition_space(rows, partition_chars[partition])
      end
      (7...10).each do |partition|
        seats = partition_space(seats, partition_chars[partition])
      end
      # both should only have 1 value left after processing
      assigned_seat = {
        row: rows[0],
        seat: seats[0],
        id: rows[0] * 8 + seats[0]
      }
      seat_ids << assigned_seat
    end
    seat_ids
  end

  def partition_space(space, partition_char)
    case partition_char
    when 'F', 'L'
      space.pop(space.count / 2)
    when 'B', 'R'
      space.shift(space.count / 2)
    end
    space
  end

  def find_empty_seat
    search(boarding_list.map { |a| a[:id] }.sort, boarding_list.count)
  end

  def search(list, size)
    a = 0
    mid = 0
    b = size - 1
    while b > a + 1
      mid = (a + b) / 2
      if (list[a] - a) != (list[mid] - mid)
        b = mid
      elsif (list[b] - b) != (list[mid] - mid)
        a = mid
      end
    end
    list[mid] - 1
  end
end
