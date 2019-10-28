class Triplet
    attr_reader :nums
  
    def sum
      nums.inject(0, :+)
    end
  
    def initialize(*nums)
      @nums = nums
    end
  
    def pythagorean?
      nums[0]**2 + nums[1]**2 == nums[2]**2
    end
  
    def product
      nums.reduce(:*)
    end
  
    def self.where(obj)
      res = []
      from = obj[:min_factor] || 1
      to = obj[:max_factor]
      find_triplets(from, res, to)
      obj[:sum].nil? ? res : res.select { |triplet| triplet.sum == obj[:sum] }
    end
  
    private
  
    def self.find_triplets(from, res, to)
      (from..to).each do |a|
        b = a + 1
        c = b + 1
        while c <= to
          c += 1 while c * c < a * a + b * b
          res << new(a, b, c) if c <= to && c * c == a * a + b * b
          b += 1
        end
      end
    end
  end