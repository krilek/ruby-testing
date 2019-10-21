class Hamming
    def self.compute(first, second)
        if first.length != second.length
            raise ArgumentError
        end
        hamming = 0
        second_chars = second.split('')
        first.each_char.with_index do |c, index|
            if second_chars[index] != c
                hamming+=1;
            end
        end
        return hamming
    end
end