class Grep
    @@line_num = '-n'
    @@insensitive = '-i'
    @@output_filename = '-l'
    @@invert = '-v'
    @@match_whole_line = '-x'
    def self.grep(pattern, flags, files)
        regex_pattern = prepare_regexp(pattern, flags)
        files_amount = files.length
        final_output = ""
        files.each.with_index { |filename, file_nr|
            output = ""
            matches = 0
            File.foreach(filename).with_index { |line, index| 
                is_match = line.match(regex_pattern)
                if is_match && !(flags.include? @@invert)
                    if matches > 0 
                        output += "\n"
                    end
                    output += prepare_line(line, index, flags, filename, files_amount)
                    matches += 1
                elsif !is_match && (flags.include? @@invert)
                    if flags.include? @@invert
                        if matches > 0 
                            output += "\n"
                        end
                        output += prepare_line(line, index, flags, filename, files_amount)
                        matches += 1
                    end 
                end
            }
            output = prepare_output(output, flags, files, file_nr, matches)
            if output != ""
                final_output += "#{output}\n"
            end
        }
        return final_output.chomp
    end

    def self.prepare_line(line, index, flags, filename, files_amount)
        x = ""
        if flags.include? @@line_num
            x = "#{index+1}:#{line.strip}"
        else
            x = "#{line.strip}"
        end
        if files_amount > 1 
            x = "#{filename}:#{x}"
        end
        return x
    end

    def self.prepare_regexp(pattern, flags)
        sufix = prefix = '.*'
        if flags.include? @@match_whole_line
            prefix = '^'
            sufix = '$'
        end
        pattern = "#{prefix}#{pattern}#{sufix}"
        if flags.include? @@insensitive
            regex_pattern = Regexp.new pattern, Regexp::IGNORECASE
        else
            regex_pattern = Regexp.new pattern
        end
    end

    def self.prepare_output(current_output, flags, files, file_nr, matches)
        if(flags.include? @@output_filename)
            current_output = ""
            if matches > 0
                current_output += "#{files[file_nr]}"
            end
        end
        return current_output
    end
end