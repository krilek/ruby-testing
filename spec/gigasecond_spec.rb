# frozen_string_literal: true

require_relative '../lib/gigasecond.rb'

RSpec.describe Gigasecond do
  describe '#Gigasecond.from' do
    it 'Verifies basic time calculation from date specified and 1E9 seconds later' do
      expected_time = Time.utc(2043, 1, 1, 1, 46, 40)
      start_time = Time.utc(2011, 4, 25, 0, 0, 0)
      expect(Gigasecond.from(start_time)).to eq expected_time
    end
    it 'Verifies only time specified' do
      expected_time = Time.utc(2009, 2, 19, 1, 46, 40)
      start_time = Time.utc(1977, 6, 13, 0, 0, 0)
      expect(Gigasecond.from(start_time)).to eq expected_time
    end
    it 'Tests only date specification of time' do
      expect(Gigasecond.from(Time.utc(1959, 7, 19, 0, 0, 0))).to eq Time.utc(1991, 3, 27, 1, 46, 40)
    end
    it 'Tests full time specified' do
      expect(Gigasecond.from(Time.utc(2015, 1, 24, 22, 0, 0))).to eq Time.utc(2046, 10, 2, 23, 46, 40)
    end
    it 'Tests full time with day roll over' do
      expect(Gigasecond.from(Time.utc(2015, 1, 24, 23, 59, 59))).to eq Time.utc(2046, 10, 3, 1, 46, 39)
    end
  end
end
