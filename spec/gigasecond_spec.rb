require_relative '../lib/gigasecond.rb'

RSpec.describe Gigasecond do
  describe "#Gigasecond.from" do
    it "Verifies basic time calculation from date specified Time.utc(2043, 1, 1, 1, 46, 40) and 1E9 seconds later" do
      expected_time = Time.utc(2043, 1, 1, 1, 46, 40)
      start_time = Time.utc(2011, 4, 25, 0, 0, 0)
      expect(Gigasecond.from(start_time)).to eq expected_time
    end

    it "verifies only time time specified" do
      expected_time = Time.utc(2009, 2, 19, 1, 46, 40)
      start_time = Time.utc(1977, 6, 13, 0, 0, 0)
      expect(Gigasecond.from(start_time)).to eq expected_time
    end
  end
end