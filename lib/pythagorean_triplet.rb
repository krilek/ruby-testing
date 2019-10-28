class Triplet
  include Enumerable

  def initialize a, b, c
    @a, @b, @c = [a, b, c].sort
  end

  def product
    self.reduce(&:*)
  end

  def pythagorean? a=@a, b=@b, c=@c
    a ** 2 + b ** 2 == c ** 2
  end

  def each &block
    [@a, @b, @c].each(&block)
  end

  class << self
    DEFAULT_OPTIONS = { min_factor: 0 }

    def where options={}
      min, max, sum = merge_defaults(options)

      (min..max).each_with_object([]) do |a, triplets|
        ((a + 1)..max).each do |b|
          ((b + 1)..max).each do |c|
            next if sum && sum != a + b + c

            candidate = Triplet.new(a, b, c)

            triplets << candidate if candidate.pythagorean?
          end
        end
      end
    end

    private

      def merge_defaults options
        DEFAULT_OPTIONS
          .merge(options)
          .values_at(*%i{min_factor max_factor sum})
      end
  end
end