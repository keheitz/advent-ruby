class Six
    def initialize
        @anyone_answered = []
        @everyone_answered = []
        parsed_file = File.read('./lib/twenty/inputs/six.txt').split(/\n{2,}/)
        parsed_file.each do |group|
            individual_answers = group.split("\n").map { |line| line.split("") }
            @anyone_answered << individual_answers.flatten.uniq
            @everyone_answered << individual_answers.inject(:&) 
        end
    end

    def part_one
        sum_all(@anyone_answered)
    end

    def part_two
        sum_all(@everyone_answered)
    end

    def sum_all(answers)
        answers.map{ |q| q.count }.inject(0){|sum,x| sum + x }
    end
end