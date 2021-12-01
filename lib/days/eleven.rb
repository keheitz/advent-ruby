class Eleven
    def initialize
        @seats = []
        File::readlines('./lib/inputs/eleven.txt').map(&:chomp).each_with_index do |line, li|
            line.chars.each_with_index do |char, ci| 
                @seats << {
                    row: li,
                    aisle: ci,
                    loc: "#{li},#{ci}",
                    seat: seat?(char),
                    occupied: false
                }
            end
        end
    end

    # this takes a few minutes to run...
    def part_one
        # changes_possible = true
        # while changes_possible
        #     changeset = change_seats_adjacency
        #     changes_possible = changeset.length > 0
        #     apply_changeset(changeset)
        # end
        # @seats.count { |seat| seat[:occupied] == true }
        ""
    end

    def part_two
        @seats.each do |seat|
            seat[:neighbors] = find_nearest_visible_seats(seat)
        end
        ""
        # changes_possible = true
        # while changes_possible
        #     changeset = change_seats_visibility
        #     changes_possible = changeset.length > 0
        #     apply_changeset(changeset)
        # end
        # @seats.count { |seat| seat[:occupied] == true }
    end

    def change_seats_adjacency
        changeset = []
        @seats.each do |seat|
            next unless seat[:seat]
            if seat[:occupied] && adjacency(seat) >= 4
                changeset << seat[:loc]
            elsif !seat[:occupied] && adjacency(seat) == 0
                changeset << seat[:loc]
            end
        end
        return changeset
    end

    def adjacency(center)
        @seats.count { |seat| is_adjacent_and_occupied?(center, seat) }
    end

    def is_adjacent_and_occupied?(center, seat)
        seat[:seat] == true && (seat[:row] >= center[:row] - 1) && (seat[:row] <= center[:row] + 1) && (seat[:aisle] >= center[:aisle] - 1) && (seat[:aisle] <= center[:aisle] + 1) && (seat[:row] != center[:row] || seat[:aisle] != center[:aisle]) && seat[:occupied] == true
    end

    def find_nearest_visible_seats(center)
        seat_map = @seats.map{ |seat| slope_and_distance(center,seat) }
        seat_map.each do |i|
            pp i
        end
    end

    def slope_and_distance(center, seat)
        {
            loc: seat[:loc],
            x: seat[:row] - center[:row],
            y: seat[:aisle] - center[:aisle],
            dir: ((seat[:row] - center[:row]) / (seat[:aisle] - center[:aisle])).to_r,
            dist: (seat[:row] - center[:row]).abs + (seat[:aisle] - center[:aisle]).abs
        }
    end

    def change_seats_visibility
        changeset = []
        @seats.each do |seat|
            next unless seat[:seat]
            if seat[:occupied] && visibility(seat) >= 5
                changeset << seat[:loc]
            elsif !seat[:occupied] && visibility(seat) == 0
                changeset << seat[:loc]
            end
        end
        return changeset
    end

    # def visibility(center)
    #     @seats.count{ |seat| is_visible_and_occupied?(center, seat) }
    # end

    # def is_visible_and_occupied?(center, seat)
    #     # visible_seats = @seats.
    # end

    def apply_changeset(changeset)
        @seats = @seats.each do |seat| 
            seat[:occupied] = !seat[:occupied] if changeset.include? seat[:loc]
        end
    end

    def seat?(char)
        char == "L"
    end
end