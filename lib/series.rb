class Series
    def initialize(series)
        @series = series
    end
    def slices(amount)
        if(amount > @series.length)
            raise ArgumentError
        end
        @series.each_char.each_cons(amount).map(&:join)
    end
end