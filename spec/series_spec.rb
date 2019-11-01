# frozen_string_literal: true

require_relative('../lib/series')
RSpec.describe Series do
  it 'Tests simple slices of one' do
    series = Series.new('01234')
    expect(series.slices(1)).to(eq(%w[0 1 2 3 4]))
  end
  it 'Tests simple slices of one again' do
    series = Series.new('92834')
    expect(series.slices(1)).to(eq(%w[9 2 8 3 4]))
  end
  it 'Tests simple slices of two' do
    series = Series.new('01234')
    expect(series.slices(2)).to(eq(%w[01 12 23 34]))
  end
  it 'Tests other slices of two' do
    series = Series.new('98273463')
    expected = %w[98 82 27 73 34 46 63]
    expect(series.slices(2)).to(eq(expected))
  end
  it 'Tests simple slices of two again' do
    series = Series.new('37103')
    expect(series.slices(2)).to(eq(%w[37 71 10 03]))
  end
  it 'Tests simple slices of three' do
    series = Series.new('01234')
    expect(series.slices(3)).to(eq(%w[012 123 234]))
  end
  it 'Tests simple slices of three again' do
    series = Series.new('31001')
    expect(series.slices(3)).to(eq(%w[310 100 001]))
  end
  it 'Tests other slices of three' do
    series = Series.new('982347')
    expect(series.slices(3)).to(eq(%w[982 823 234 347]))
  end
  it 'Tests simple slices of four' do
    series = Series.new('01234')
    expect(series.slices(4)).to(eq(%w[0123 1234]))
  end
  it 'Tests simple slices of four again' do
    series = Series.new('91274')
    expect(series.slices(4)).to(eq(%w[9127 1274]))
  end
  it 'Tests simple slices of five' do
    series = Series.new('01234')
    expect(series.slices(5)).to(eq(['01234']))
  end
  it 'Tests simple slices of five again' do
    series = Series.new('81228')
    expect(series.slices(5)).to(eq(['81228']))
  end
  it 'Tests simple slice that blows up' do
    series = Series.new('01234')
    expect do
      series.slices(6)
    end.to(raise_error(ArgumentError))
  end
  it 'Tests more complicated slice that blows up' do
    slice_string = '01032987583'
    series = Series.new(slice_string)
    expect do
      series.slices((slice_string.length + 1))
    end.to(raise_error(ArgumentError))
  end
  it 'Tests sequential slices' do
    series = Series.new('1234')
    expect(series.slices(2)).to(eq(%w[12 23 34]))
    expect(series.slices(3)).to(eq(%w[123 234]))
  end
end
