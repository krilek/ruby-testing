# frozen_string_literal: true

require_relative('../lib/matching_brackets')
RSpec.describe Brackets do
  it 'Tests paired square brackets' do
    expect(Brackets.paired?('[]')).to(be_truthy)
  end
  it 'Tests empty string' do
    expect(Brackets.paired?('')).to(be_truthy)
  end
  it 'Tests unpaired brackets' do
    expect(Brackets.paired?('[[')).to(be_falsey)
  end
  it 'Tests wrong ordered brackets' do
    expect(Brackets.paired?('}{')).to(be_falsey)
  end
  it 'Tests wrong closing bracket' do
    expect(Brackets.paired?('{]')).to(be_falsey)
  end
  it 'Tests paired with whitespace' do
    expect(Brackets.paired?('{ }')).to(be_truthy)
  end
  it 'Tests partially paired brackets' do
    expect(Brackets.paired?('{[])')).to(be_falsey)
  end
  it 'Tests simple nested brackets' do
    expect(Brackets.paired?('{[]}')).to(be_truthy)
  end
  it 'Tests several paired brackets' do
    expect(Brackets.paired?('{}[]')).to(be_truthy)
  end
  it 'Tests paired and nested brackets' do
    expect(Brackets.paired?('([{}({}[])])')).to(be_truthy)
  end
  it 'Tests unopened closing brackets' do
    expect(Brackets.paired?('{[)][]}')).to(be_falsey)
  end
  it 'Tests unpaired and nested brackets' do
    expect(Brackets.paired?('([{])')).to(be_falsey)
  end
  it 'Tests paired and wrong nested brackets' do
    expect(Brackets.paired?('[({]})')).to(be_falsey)
  end
  it 'Tests paired and incomplete brackets' do
    expect(Brackets.paired?('{}[')).to(be_falsey)
  end
  it 'Tests too many closing brackets' do
    expect(Brackets.paired?('[]]')).to(be_falsey)
  end
  it 'Tests math expression' do
    expect(Brackets.paired?('(((185 + 223.85) * 15) - 543)/2')).to(be_truthy)
  end
  it 'Tests complex latex expression' do
    string = ('\\left(\\begin{array}{cc} \\frac{1}{3} & x\\ ' + '\\mathrm{e}^{x} &... x^2 \\end{array}\\right)')
    expect(Brackets.paired?(string)).to(be_truthy)
  end
end
