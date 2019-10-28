class Brackets
    @@opening = ['(', '[', '{']
    @@closing = [')', ']', '}']
    def self.paired?(input)
        stack = []
        input.each_char.with_index { |c, i|
            if(@@opening.include? c)
                stack << c
            elsif (@@closing.include? c)
                # closing moment
                index = @@closing.find_index(c)
                if (stack.last == @@opening[index])
                    stack.pop
                else
                    return false
                end
            end
        }
        stack.empty?
    end
end