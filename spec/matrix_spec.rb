# frozen_string_literal: true

require_relative('../lib/matrix')
RSpec.describe Matrix do
  it 'Tests extracting a row' do
    matrix = Matrix.new("1 2\n10 20")
    expect(matrix.rows[0]).to(eq([1, 2]))
  end
  it 'Tests extracting same row again' do
    matrix = Matrix.new("9 7\n8 6")
    expect(matrix.rows[0]).to(eq([9, 7]))
  end
  it 'Tests extracting other row' do
    matrix = Matrix.new("9 8 7\n19 18 17")
    expect(matrix.rows[1]).to(eq([19, 18, 17]))
  end
  it 'Tests extracting other row again' do
    matrix = Matrix.new("1 4 9\n16 25 36")
    expect(matrix.rows[1]).to(eq([16, 25, 36]))
  end
  it 'Tests extracting a column' do
    matrix = Matrix.new("1 2 3\n4 5 6\n7 8 9\n 8 7 6")
    expect(matrix.columns[0]).to(eq([1, 4, 7, 8]))
  end
  it 'Tests extracting another column' do
    matrix = Matrix.new("89 1903 3\n18 3 1\n9 4 800")
    expect(matrix.columns[1]).to(eq([1903, 3, 4]))
  end
end
