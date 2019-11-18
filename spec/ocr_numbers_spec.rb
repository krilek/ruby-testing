# frozen_string_literal: true

require_relative('../lib/ocr_numbers')
RSpec.describe OcrNumbers do
  describe '#convert' do
    context 'when wrong input' do
      it 'unreadable but correctly sized inputs return question mark' do
        input = ['   ',
                 '  _',
                 '  |',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('?'))
      end
      it 'with a number of lines that is not a multiple of four raises an error' do
        input = [' _ ',
                 '| |',
                 '   '].join("\n")
        expect { OcrNumbers.convert(input) }.to(raise_error(ArgumentError))
      end
      it 'with a number of columns that is not a multiple of three raises an error' do
        input = ['    ',
                 '   |',
                 '   |',
                 '    '].join("\n")
        expect { OcrNumbers.convert(input) }.to(raise_error(ArgumentError))
      end
    end
    context 'single digit input' do
      it 'Recognizes 0' do
        input = [' _ ',
                '| |',
                '|_|',
                '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('0'))
      end
      it 'Recognizes 1' do
        input = ['   ',
                '  |',
                '  |',
                '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('1'))
      end
      it 'Recognizes 2' do
        input = [' _ ',
                 ' _|',
                 '|_ ',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('2'))
      end
      it 'Recognizes 3' do
        input = [' _ ',
                 ' _|',
                 ' _|',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('3'))
      end
      it 'Recognizes 4' do
        input = ['   ',
                 '|_|',
                 '  |',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('4'))
      end
      it 'Recognizes 5' do
        input = [' _ ',
                 '|_ ',
                 ' _|',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('5'))
      end
      it 'Recognizes 6' do
        input = [' _ ',
                 '|_ ',
                 '|_|',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('6'))
      end
      it 'Recognizes 7' do
        input = [' _ ',
                 '  |',
                 '  |',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('7'))
      end
      it 'Recognizes 8' do
        input = [' _ ',
                 '|_|',
                 '|_|',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('8'))
      end
      it 'Recognizes 9' do
        input = [' _ ',
                 '|_|',
                 ' _|',
                 '   '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('9'))
      end
    end
    context 'when multiple digits' do
      it 'Recognizes 110101100' do
        input = ['       _     _        _  _ ',
                '  |  || |  || |  |  || || |',
                '  |  ||_|  ||_|  |  ||_||_|',
                '                           '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('110101100'))
      end
      it 'garbled numbers in a string are replaced with question mark' do
        input = ['       _     _           _ ',
                '  |  || |  || |     || || |',
                '  |  | _|  ||_|  |  ||_||_|',
                '                           '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('11?10?1?0'))
      end

      it 'Recognizes string of decimal numbers' do
        input = ['    _  _     _  _  _  _  _  _ ',
                '  | _| _||_||_ |_   ||_||_|| |',
                '  ||_  _|  | _||_|  ||_| _||_|',
                '                              '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('1234567890'))
      end
      it 'Test that numbers separated by empty lines are recognized lines are joined by commas' do
        input = ['    _  _ ',
                '  | _| _|',
                '  ||_  _|',
                '         ',
                '    _  _ ',
                '|_||_ |_ ',
                '  | _||_|',
                '         ',
                ' _  _  _ ',
                '  ||_||_|',
                '  ||_| _|',
                '         '].join("\n")
        expect(OcrNumbers.convert(input)).to(eq('123,456,789'))
      end
    end
    
  end

  
end
