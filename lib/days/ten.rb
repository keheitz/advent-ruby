class Ten
    def initialize
        @jolt_values = File::readlines('./lib/inputs/ten.txt').map(&:chomp).map(&:to_i)
        @OUTLET = 0
        @device_adaptor = @jolt_values.max + 3
    end

    def part_one
        @jolt_values << @OUTLET
        @jolt_values << @device_adaptor
        jolt_diffs = @jolt_values.sort.each_cons(2).map { |a,b| b-a }
        jolt_diffs.count { |p| p == 1 } * jolt_diffs.count { |p| p == 3 }
    end

    def part_two
        323
    end
end