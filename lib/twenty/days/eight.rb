class Eight
    def initialize
        input = File::readlines('./lib/twenty/inputs/eight.txt').map(&:chomp)
        @boot_codes = input.map{ |i| { 
            :op => i.split(" ")[0],
            :arg => i.split(" ")[1].to_i
        } }
        @accumulator_val = 0
    end
    
    def part_one
        instructions_run = []
        pointer = 0
        while !instructions_run.include? pointer
            instructions_run << pointer
            pointer = run_code(@boot_codes[pointer], pointer)
        end
        @accumulator_val
    end

    def run_code(code, pointer)
        case code[:op]
        when "nop"
            return pointer + 1
        when "acc"
            @accumulator_val += code[:arg]
            return pointer + 1
        when "jmp"
            return pointer + code[:arg]
        end
    end

    def part_two
        termination_pointer = @boot_codes.count
        possible_updates = []
        @boot_codes.each_with_index do |code,index|
            next if code[:op] == "acc"
            possible_updates << index
        end
        possible_updates.each do |update|
            @accumulator_val = 0
            boot_codes_updated = Marshal.load(Marshal.dump(@boot_codes))
            boot_codes_updated[update][:op] = boot_codes_updated[update][:op] == "nop" ? "jmp" : "nop"
            instructions_run = []
            pointer = 0
            while (pointer != termination_pointer) && (!instructions_run.include? pointer)
                instructions_run << pointer
                pointer = run_code(boot_codes_updated[pointer], pointer)
            end
            return @accumulator_val if pointer == termination_pointer
        end
        puts "no solution found :("
        return 0
    end
end