class Matrix
    attr_reader :rows, :columns
    def initialize(matrix_str)
        @rows = []
        @columns = []
        matrix_str.split("\n").each_with_index { |row|
            @rows << row.split(' ').map(&:to_i)
            
        }
        @columns = rows.transpose()
    end
end