
require_relative("../lib/acronym")
RSpec.describe Acronym do
  it 'Tests basic functionality' do
    expect(Acronym.abbreviate("Portable Network Graphics")).to(eq("PNG"))
  end
  it 'Tests lowercase words' do
    expect(Acronym.abbreviate("Ruby on Rails")).to(eq("ROR"))
  end
  it 'Tests punctuation' do
    expect(Acronym.abbreviate("First In, First Out")).to(eq("FIFO"))
  end
  it 'Tests all caps word' do
    expect(Acronym.abbreviate("GNU Image Manipulation Program")).to(eq("GIMP"))
  end
  it 'Tests punctuation without whitespace' do
    expect(Acronym.abbreviate("Complementary metal-oxide semiconductor")).to(eq("CMOS"))
  end
  it 'Tests very long abbreviation' do
    expect(Acronym.abbreviate("Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me")).to(eq("ROTFLSHTMDCOALM"))
  end
  it 'Tests consecutive delimiters' do
    expect(Acronym.abbreviate("Something - I made up from thin air")).to(eq("SIMUFTA"))
  end
end
