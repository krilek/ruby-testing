class ResistorColorDuo
    @@colors = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"] 
    def self.value(values)
        return @@colors.index(values[0])*10+@@colors.index(values[1])
    end
end