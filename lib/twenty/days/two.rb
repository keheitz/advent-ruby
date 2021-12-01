require "pp"

class Two
    def part_one
        count_valid(validate_letter_count)
    end

    def part_two
        count_valid(validate_letter_position)
    end

    def count_valid(passwords)
        passwords.count { |p| p["valid"] == true }
    end

    def passwords_and_rules
        input_lines = File::readlines('./lib/twenty/inputs/two.txt').map(&:chomp)
        passwords = []
        input_lines.each do |line|
            values = line.split
            input_parsed = {
                "first_val" => values[0].split('-')[0].to_i,
                "second_val" => values[0].split('-')[1].to_i,
                "letter" => values[1].split(':')[0],
                "string" => values[2],
            }
            passwords << input_parsed
        end
        return passwords
    end

    def validate_letter_count
        passwords_and_rules.each do |password|
            letter_count = password["string"].count(password["letter"])
            password["valid"] = letter_count <= password["second_val"] && letter_count >= password["first_val"]
        end
    end

    def validate_letter_position
        passwords_and_rules.each do |password|
            count_positional_letters = 0
            string = password["string"]
            letter = password["letter"]
            if string[password["first_val"] - 1] == letter 
                count_positional_letters += 1
            end
            if string[password["second_val"] - 1] == letter
                count_positional_letters += 1
            end
            password["valid"] = count_positional_letters == 1
        end
    end
end 