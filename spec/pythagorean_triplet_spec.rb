# frozen_string_literal: true

require_relative('../lib/pythagorean_triplet')
RSpec.describe Triplet do
  it 'Tests sum' do
    expect(Triplet.new(3, 4, 5).sum).to(eq(12))
  end
  it 'Tests product' do
    expect(Triplet.new(3, 4, 5).product).to(eq(60))
  end
  it 'Tests pythagorean' do
    expect(Triplet.new(3, 4, 5).pythagorean?).to(eq(true))
  end
  it 'Tests not pythagorean' do
    expect(Triplet.new(5, 6, 7).pythagorean?).to(eq(false))
  end
  it 'Tests triplets upto 10' do
    triplets = Triplet.where(max_factor: 10)
    products = triplets.map(&:product).sort
    expect(products).to(eq([60, 480]))
  end
  it 'Tests triplets from 11 upto 20' do
    triplets = Triplet.where(min_factor: 11, max_factor: 20)
    products = triplets.map(&:product).sort
    expect(products).to(eq([3840]))
  end
  it 'Tests triplets where sum x' do
    triplets = Triplet.where(sum: 180, max_factor: 100)
    products = triplets.map(&:product).sort
    expect(products).to(eq([118_080, 168_480, 202_500]))
  end
  it 'Tests where sum 1000' do
    triplets = Triplet.where(sum: 1000, min_factor: 200, max_factor: 425)
    products = triplets.map(&:product)
    expect(products).to(eq([31_875_000]))
  end
end
