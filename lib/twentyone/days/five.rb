# frozen_string_literal: true

module TwentyOne
  class Five
    def initialize
      input = File.readlines('./lib/twentyone/inputs/five.txt').map(&:chomp)
      @nearby_vent_lines = nearby_vent_lines(input)
      @vent_points = {}
      @nearby_vent_lines.each do |vent|
        pp vent
        xdiff = vent[:start_x] - vent[:end_x]
        ydiff = vent[:start_y] - vent[:end_y]
        # only tracking horizontal and vertical lines
        puts "absolute value x #{xdiff.abs} #{xdiff.abs.positive?} y #{ydiff.abs} #{ydiff.abs.positive?}"
        if xdiff.abs.positive? && ydiff.abs.positive?
          x_dir_step = xdiff.positive? ? 1 : -1
          y_dir_step = ydiff.positive? ? 1 : -1
          y_tracker = 0
          (0).step(by: x_dir_step, to: xdiff).each do |step|
            point = "#{vent[:start_x] - step},#{vent[:start_y] - y_tracker}"
            increment_point_count(point)
            y_tracker += y_dir_step
          end
        elsif xdiff.abs.positive?
          dir_step = xdiff.positive? ? 1 : -1
          (0).step(by: dir_step, to: xdiff).each do |step|
            point = "#{vent[:start_x] - step},#{vent[:start_y]}"
            increment_point_count(point)
          end
        elsif ydiff.abs.positive?
          dir_step = ydiff.positive? ? 1 : -1
          (0).step(by: dir_step, to: ydiff).each do |step|
            point = "#{vent[:start_x]},#{vent[:start_y] - step}"
            increment_point_count(point)
          end
        end
      end
    end

    def part_one
      @vent_points.values.group_by { |i| i }.transform_values(&:count)
    end

    def part_two
      ''
    end

    private

    def nearby_vent_lines(input)
      input.map do |i|
        points = i.split('->')
        starting = point_x_and_y(points[0])
        ending = point_x_and_y(points[1])
        {
          start_x: starting[0],
          start_y: starting[1],
          end_x: ending[0],
          end_y: ending[1]
        }
      end
    end

    def increment_point_count(point)
      @vent_points[point] = if @vent_points.key?(point)
                              @vent_points[point] + 1
                            else
                              1
                            end
    end

    def point_x_and_y(point)
      point.chomp.split(',').map(&:to_i)
    end

    def multiply_final_value(depth, horizontal_distance)
      product = depth * horizontal_distance
      product.to_s
    end
  end
end
