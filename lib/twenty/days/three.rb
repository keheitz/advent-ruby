# frozen_string_literal: true

class Three
  # should refactor to use Matrix
  def initialize
    @fragment = read_map_fragment
    @parsed_map = parse_map(@fragment)
    @fragment_width = @fragment[0].length
  end

  def part_one
    find_trees_in_path([3, 1])
  end

  def part_two
    # for each slope[0] is the moves along x coord
    # and slope[1] is moves along y coord
    slopes = [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2]
    ]

    tree_counts = slopes.map { |slope| find_trees_in_path(slope) }
    tree_counts.inject(:*)
  end

  def read_map_fragment
    File.readlines('./lib/twenty/inputs/three.txt').map(&:chomp)
  end

  def parse_map(fragment)
    y_coords = []
    fragment.each_with_index do |line, i|
      y_coords[i] = (0...line.length).find_all { |j| line[j, 1] == '#' }
    end
    y_coords
  end

  # assumes we start at 0,0 on map
  def find_trees_in_path(slope)
    location = [0, 0]
    tree_count = 0
    move_count = @parsed_map.length / slope[1]
    (0...move_count).each do |_i|
      tree_count += 1 if @parsed_map[location[1]].include? location[0] % @fragment_width
      location = location.zip(slope).map { |val, add| val + add }
    end
    tree_count
  end
end
