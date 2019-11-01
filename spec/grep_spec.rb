# frozen_string_literal: true

require_relative('../lib/grep')
RSpec.describe Grep do
  before do
    IO.write('iliad.txt', "Achilles sing, O Goddess! Peleus' son;\nHis wrath pernicious, who ten thousand woes\nCaused to Achaia's host, sent many a soul\nIllustrious into Ades premature,\nAnd Heroes gave (so stood the will of Jove)\nTo dogs and to all ravening fowls a prey,\nWhen fierce dispute had separated once\nThe noble Chief Achilles from the son\nOf Atreus, Agamemnon, King of men.\n")
    IO.write('midsummer-night.txt', "I do entreat your grace to pardon me.\nI know not by what power I am made bold,\nNor how it may concern my modesty,\nIn such a presence here to plead my thoughts;\nBut I beseech your grace that I may know\nThe worst that may befall me in this case,\nIf I refuse to wed Demetrius.\n")
    IO.write('paradise-lost.txt', "Of Mans First Disobedience, and the Fruit\nOf that Forbidden Tree, whose mortal tast\nBrought Death into the World, and all our woe,\nWith loss of Eden, till one greater Man\nRestore us, and regain the blissful Seat,\nSing Heav'nly Muse, that on the secret top\nOf Oreb, or of Sinai, didst inspire\nThat Shepherd, who first taught the chosen Seed\n")
  end
  after do
    File.delete('iliad.txt')
    File.delete('midsummer-night.txt')
    File.delete('paradise-lost.txt')
  end
  it 'Tests one file one match without flags' do
    pattern = 'Agamemnon'
    flags = []
    files = ['iliad.txt']
    expected = "Of Atreus, Agamemnon, King of men.\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match print line numbers flag' do
    pattern = 'Forbidden'
    flags = ['-n']
    files = ['paradise-lost.txt']
    expected = "2:Of that Forbidden Tree, whose mortal tast\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match case insensitive flag' do
    pattern = 'FORBIDDEN'
    flags = ['-i']
    files = ['paradise-lost.txt']
    expected = "Of that Forbidden Tree, whose mortal tast\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match print file names flag' do
    pattern = 'Forbidden'
    flags = ['-l']
    files = ['paradise-lost.txt']
    expected = "paradise-lost.txt\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match match entire lines flag' do
    pattern = 'With loss of Eden, till one greater Man'
    flags = ['-x']
    files = ['paradise-lost.txt']
    expected = "With loss of Eden, till one greater Man\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match multiple flags' do
    pattern = 'OF ATREUS, Agamemnon, KIng of MEN.'
    flags = ['-n', '-i', '-x']
    files = ['iliad.txt']
    expected = "9:Of Atreus, Agamemnon, King of men.\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches without flags' do
    pattern = 'may'
    flags = []
    files = ['midsummer-night.txt']
    expected = "Nor how it may concern my modesty,\nBut I beseech your grace that I may know\nThe worst that may befall me in this case,\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches print line numbers flag' do
    pattern = 'may'
    flags = ['-n']
    files = ['midsummer-night.txt']
    expected = "3:Nor how it may concern my modesty,\n5:But I beseech your grace that I may know\n6:The worst that may befall me in this case,\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches match entire lines flag' do
    pattern = 'may'
    flags = ['-x']
    files = ['midsummer-night.txt']
    expected = "\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches case insensitive flag' do
    pattern = 'ACHILLES'
    flags = ['-i']
    files = ['iliad.txt']
    expected = "Achilles sing, O Goddess! Peleus' son;\nThe noble Chief Achilles from the son\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches inverted flag' do
    pattern = 'Of'
    flags = ['-v']
    files = ['paradise-lost.txt']
    expected = "Brought Death into the World, and all our woe,\nWith loss of Eden, till one greater Man\nRestore us, and regain the blissful Seat,\nSing Heav'nly Muse, that on the secret top\nThat Shepherd, who first taught the chosen Seed\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file no matches various flags' do
    pattern = 'Gandalf'
    flags = ['-n', '-l', '-x', '-i']
    files = ['iliad.txt']
    expected = "\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file one match file flag takes precedence over line flag' do
    pattern = 'ten'
    flags = ['-n', '-l']
    files = ['iliad.txt']
    expected = "iliad.txt\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests one file several matches inverted and match entire lines flags' do
    pattern = 'Illustrious into Ades premature,'
    flags = ['-x', '-v']
    files = ['iliad.txt']
    expected = "Achilles sing, O Goddess! Peleus' son;\nHis wrath pernicious, who ten thousand woes\nCaused to Achaia's host, sent many a soul\nAnd Heroes gave (so stood the will of Jove)\nTo dogs and to all ravening fowls a prey,\nWhen fierce dispute had separated once\nThe noble Chief Achilles from the son\nOf Atreus, Agamemnon, King of men.\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files one match without flags' do
    pattern = 'Agamemnon'
    flags = []
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "iliad.txt:Of Atreus, Agamemnon, King of men.\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files several matches without flags' do
    pattern = 'may'
    flags = []
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "midsummer-night.txt:Nor how it may concern my modesty,\nmidsummer-night.txt:But I beseech your grace that I may know\nmidsummer-night.txt:The worst that may befall me in this case,\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files several matches print line numbers flag' do
    pattern = 'that'
    flags = ['-n']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "midsummer-night.txt:5:But I beseech your grace that I may know\nmidsummer-night.txt:6:The worst that may befall me in this case,\nparadise-lost.txt:2:Of that Forbidden Tree, whose mortal tast\nparadise-lost.txt:6:Sing Heav'nly Muse, that on the secret top\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files one match print file names flag' do
    pattern = 'who'
    flags = ['-l']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "iliad.txt\nparadise-lost.txt\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files several matches case insensitive flag' do
    pattern = 'TO'
    flags = ['-i']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = <<~eos
      iliad.txt:Caused to Achaia's host, sent many a soul
      iliad.txt:Illustrious into Ades premature,
      iliad.txt:And Heroes gave (so stood the will of Jove)
      iliad.txt:To dogs and to all ravening fowls a prey,
      midsummer-night.txt:I do entreat your grace to pardon me.
      midsummer-night.txt:In such a presence here to plead my thoughts;
      midsummer-night.txt:If I refuse to wed Demetrius.
      paradise-lost.txt:Brought Death into the World, and all our woe,
      paradise-lost.txt:Restore us, and regain the blissful Seat,
      paradise-lost.txt:Sing Heav'nly Muse, that on the secret top
    eos
    expect(Grep.grep(pattern, flags, files)).to(eq(expected.rstrip))
  end
  it 'Tests multiple files several matches inverted flag' do
    pattern = 'a'
    flags = ['-v']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = <<~eos
      iliad.txt:Achilles sing, O Goddess! Peleus' son;
      iliad.txt:The noble Chief Achilles from the son
      midsummer-night.txt:If I refuse to wed Demetrius.
    eos
    expect(Grep.grep(pattern, flags, files)).to(eq(expected.rstrip))
  end
  it 'Tests multiple files one match match entire lines flag' do
    pattern = 'But I beseech your grace that I may know'
    flags = ['-x']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "midsummer-night.txt:But I beseech your grace that I may know\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files one match multiple flags' do
    pattern = 'WITH LOSS OF EDEN, TILL ONE GREATER MAN'
    flags = ['-n', '-i', '-x']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "paradise-lost.txt:4:With loss of Eden, till one greater Man\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files no matches various flags' do
    pattern = 'Frodo'
    flags = ['-n', '-l', '-x', '-i']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files several matches file flag takes precedence over line number flag' do
    pattern = 'who'
    flags = ['-n', '-l']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = "iliad.txt\nparadise-lost.txt\n".rstrip
    expect(Grep.grep(pattern, flags, files)).to(eq(expected))
  end
  it 'Tests multiple files several matches inverted and match entire lines flags' do
    pattern = 'Illustrious into Ades premature,'
    flags = ['-x', '-v']
    files = ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
    expected = <<~eos
      iliad.txt:Achilles sing, O Goddess! Peleus' son;
      iliad.txt:His wrath pernicious, who ten thousand woes
      iliad.txt:Caused to Achaia's host, sent many a soul
      iliad.txt:And Heroes gave (so stood the will of Jove)
      iliad.txt:To dogs and to all ravening fowls a prey,
      iliad.txt:When fierce dispute had separated once
      iliad.txt:The noble Chief Achilles from the son
      iliad.txt:Of Atreus, Agamemnon, King of men.
      midsummer-night.txt:I do entreat your grace to pardon me.
      midsummer-night.txt:I know not by what power I am made bold,
      midsummer-night.txt:Nor how it may concern my modesty,
      midsummer-night.txt:In such a presence here to plead my thoughts;
      midsummer-night.txt:But I beseech your grace that I may know
      midsummer-night.txt:The worst that may befall me in this case,
      midsummer-night.txt:If I refuse to wed Demetrius.
      paradise-lost.txt:Of Mans First Disobedience, and the Fruit
      paradise-lost.txt:Of that Forbidden Tree, whose mortal tast
      paradise-lost.txt:Brought Death into the World, and all our woe,
      paradise-lost.txt:With loss of Eden, till one greater Man
      paradise-lost.txt:Restore us, and regain the blissful Seat,
      paradise-lost.txt:Sing Heav'nly Muse, that on the secret top
      paradise-lost.txt:Of Oreb, or of Sinai, didst inspire
      paradise-lost.txt:That Shepherd, who first taught the chosen Seed
    eos
    expect(Grep.grep(pattern, flags, files)).to(eq(expected.rstrip))
  end
end
