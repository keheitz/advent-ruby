class One
    def solve_part(part)
        case part
        when 1
            part_one
        when 2
            part_two
        else
            "Error: requested part does not exist"
        end
    end

    def part_one
        123
    end

    def part_two
        456
    end
end