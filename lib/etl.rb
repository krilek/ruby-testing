class ETL
    def self.transform(input)
        out_dict = {}        
        input.each do |key, val|
            val.each do |el|
                out_dict[el.downcase] = key
            end
        end
        return out_dict
    end
end