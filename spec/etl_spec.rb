require_relative("../lib/etl")
RSpec.describe ETL do
  it 'Tests a single letter' do
    old = { 1 => (["A"]) }
    expected = { "a" => 1 }
    expect(ETL.transform(old)).to(eq(expected))
  end
  it 'Tests single score with multiple letters' do
    old = { 1 => (["A", "E", "I", "O", "U"]) }
    expected = { "a" => 1, "e" => 1, "i" => 1, "o" => 1, "u" => 1 }
    expect(ETL.transform(old)).to(eq(expected))
  end
  it 'Tests multiple scores with multiple letters' do
    old = { 1 => (["A", "E"]), 2 => (["D", "G"]) }
    expected = { "a" => 1, "d" => 2, "e" => 1, "g" => 2 }
    expect(ETL.transform(old)).to(eq(expected))
  end
  it 'Tests multiple scores with differing numbers of letters' do
    old = { 1 => (["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]), 2 => (["D", "G"]), 3 => (["B", "C", "M", "P"]), 4 => (["F", "H", "V", "W", "Y"]), 5 => (["K"]), 8 => (["J", "X"]), 10 => (["Q", "Z"]) }
    expected = { "a" => 1, "b" => 3, "c" => 3, "d" => 2, "e" => 1, "f" => 4, "g" => 2, "h" => 4, "i" => 1, "j" => 8, "k" => 5, "l" => 1, "m" => 3, "n" => 1, "o" => 1, "p" => 3, "q" => 10, "r" => 1, "s" => 1, "t" => 1, "u" => 1, "v" => 4, "w" => 4, "x" => 8, "y" => 4, "z" => 10 }
    expect(ETL.transform(old)).to(eq(expected))
  end
end
