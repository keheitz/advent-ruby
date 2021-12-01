class Ten
    def initialize
        @jolt_values = File::readlines('./lib/inputs/ten.txt').map(&:to_i)
        @OUTLET = 0
        @device_adapter = @jolt_values.max + 3
    end

    def part_one
        @jolt_values << @OUTLET
        @jolt_values << @device_adapter
        jolt_diffs = @jolt_values.sort.each_cons(2).map { |a,b| b-a }
        jolt_diffs.count { |p| p == 1 } * jolt_diffs.count { |p| p == 3 }
    end

    def total_adapter_lens(adapters)
        adapter_cache = {}
        adapter_len = lambda do |a, idx|
            return adapter_cache[a] unless adapter_cache[a].nil?
            next_adapters_indices = (idx + 1...adapters.size).select { |i| a < adapters[i] && adapters[i] <= a + 3 }.take(3)
            return adapter_cache[a] = 1 if next_adapters_indices.empty?
            adapter_cache[a] = next_adapters_indices.map { |i| adapter_len.call(adapters[i], i) }.sum
        end
        adapter_len.call(adapters[0], 0)
    end

    def part_two
        @jolt_values << @OUTLET
        @jolt_values << @device_adapter
        @jolt_values.sort!

        total_adapter_lens(@jolt_values) / 2
    end
end