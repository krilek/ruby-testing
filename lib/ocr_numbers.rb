class OcrNumbers
    @@patterns = {
        '0' => [" _ ",
                "| |",
                "|_|",
                "   "],
        '1' => ["   ",
                "  |",
                "  |",
                "   "],
        '2' => [" _ ",
                " _|",
                "|_ ",
                "   "],
        '3' => [" _ ",
                " _|",
                " _|",
                "   "],
        '4' => ["   ",
                "|_|",
                "  |",
                "   "],
        '5' => [" _ ",
                "|_ ",
                " _|",
                "   "],
        '6' => [" _ ",
                "|_ ",
                "|_|",
                "   "],
        '7' => [" _ ",
                "  |",
                "  |",
                "   "],
        '8' => [" _ ",
                "|_|",
                "|_|",
                "   "],
        '9' => [" _ ",
                "|_|",
                " _|",
                "   "]

    }
    def self.convert(input)
        xd = input.split("\n")
        if(xd.length % 4 != 0)
            raise ArgumentError
        end
        rows = xd.length / 4
        out = ""
        for i in 0..rows-1 do
            if(i>0)
                out += ","
            end
            out += divide_row_into_numbers(xd.drop(i*4).take(4))
        end
        return out
    end

    def self.divide_row_into_numbers(input)
        vals = []
        number = []
        if(input.first.length % 3 != 0) 
            raise ArgumentError
        end
        amount_numbers = input.first.length / 3
        for i in 0..amount_numbers do
            input.each do |row|
                row = row.chars.drop(i*3).take(3)
                if row.length == 3
                    number << row.join()
                end
            end
            if(!number.empty?)
                vals << ocr_number(number)
                number.clear
            end
        end
        vals.join()
    end

    def self.ocr_number(number)
        nr = @@patterns.key(number) 
        if nr == nil
            "?"
        else
            nr
        end
    end
end