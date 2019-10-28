require 'set'
class Anagram
    def initialize(word)
        @word = word.downcase
        @letter_table = get_letter_table(@word)
    end
    def match(proposals)
        out = []
        proposals.each do |proposal|
            if(proposal.downcase != @word && @letter_table == get_letter_table(proposal.downcase))
                out << proposal
            end
        end
        return out
        # puts(@letter_table)
    end
    def get_letter_table(word)
        letter_table = {}
        word.split('').to_set.each do |c|
            letter_table[c] = word.count(c)
        end
        return letter_table
    end
end