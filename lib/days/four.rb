require "pp"

class Four
    def initialize
        parsed_file = File.read('./lib/inputs/four.txt').split(/\n{2,}/).map { |fields| fields.split(' ') }
        @passports = []
        parsed_file.each do |passport|
            hash = {}
            passport.each do |field|
                key_val = field.split(":")
                hash[key_val[0]] = key_val[1]
            end
            @passports << hash
        end
    end

    def required_fields
        %w[byr iyr eyr hgt hcl ecl pid]
    end

    def part_one
        all_required_fields.count
    end

    def part_two
        fields_match_data_rules(all_required_fields).select { |m| m["valid"] == true}.each do |p|
            pp p
            pp valid_year(p["byr"], 1920, 2002)
            pp valid_year(p["iyr"], 2010, 2020)
            pp valid_year(p["eyr"], 2020, 2030)
            pp valid_height(p["hgt"])
            pp valid_hair_color(p["hcl"])
            pp valid_eye_color(p["ecl"])
            pp valid_pid(p["pid"])
        end
        fields_match_data_rules(all_required_fields).count { |p| p["valid"] == true }

        all_required_fields.select do |passport|
            hgt_cm = passport["hgt"].scan(/(\d+)cm/).flatten.first.to_i
            hgt_in = passport["hgt"].scan(/(\d+)in/).flatten.first.to_i
        
            ((hgt_cm >= 150 && hgt_cm <= 193) || (hgt_in >= 59 && hgt_in <= 76)) &&
            passport["byr"].to_i >= 1920 && passport["byr"].to_i <= 2002 &&
            passport["iyr"].to_i >= 2010 && passport["iyr"].to_i <= 2020 &&
            passport["eyr"].to_i >= 2020 && passport["eyr"].to_i <= 2030 &&
            !(passport["hcl"] =~ /#[\d|a-f]{6}/).nil? &&
            %w[amb blu brn gry grn hzl oth].include?(passport["ecl"]) &&
            passport["pid"].length == 9
          end.count
    end

    def all_required_fields
        sufficient_fields = @passports.reject{ |x| x.size < 7 }
        sufficient_fields.select{ |y| required_fields.all? { |z| y.key? z } }
    end

    def fields_match_data_rules(passports)
        passports.each do |passport|
            passport["valid"] = check_all_rules(passport)
        end
    end

    def check_all_rules(passport)
        # pp valid_year(passport["byr"], 1920, 2002)
        # pp valid_year(passport["iyr"], 2010, 2020)
        # pp valid_year(passport["eyr"], 2020, 2030)
        # pp valid_height(passport["hgt"])
        # pp valid_hair_color(passport["hcl"])
        # pp valid_eye_color(passport["ecl"])
        # pp valid_pid(passport["pid"])

        valid_year(passport["byr"], 1920, 2002) &&
        valid_year(passport["iyr"], 2010, 2020) &&
        valid_year(passport["eyr"], 2020, 2030) &&
        valid_height(passport["hgt"]) &&
        valid_hair_color(passport["hcl"]) &&
        valid_eye_color(passport["ecl"]) &&
        valid_pid(passport["pid"])
    end

    def valid_year(year, min, max)
        return false unless year.length == 4
        year_num = year.to_i
        year_num >= min && year_num <= max
    end

    def valid_height(measurement)
        unit = measurement.split(//).last(2).join
        return false unless unit == "cm" || unit == "in"
        value = measurement.scan(/(\d+)in/).flatten.first.to_i
        case unit
        when "cm"
            return value >= 150 && value <= 193
        when "in"
            return value >= 59 && value <= 76
        else 
            return false
        end
    end

    def valid_hair_color(color)
        !(color =~ /#[\d|a-f]{6}/).nil?
    end

    def valid_eye_color(color)
        %w[amb blu brn gry grn hzl oth].include?(color)
    end

    def valid_pid(pid)
        return false unless pid.length == 9
        !(/\A[0-9]*\z/ =~ pid).nil?
    end
end