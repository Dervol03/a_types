require 'spec_helper'

context 'Numeric' do
  describe '#to_num' do
    context 'String' do
      context 'containing fixnum' do
        it 'converts to Fixnum' do
          expect('12'.to_num).to eq 12
          expect('-1'.to_num).to eq(-1)
        end
      end # on containing fixnum


      context 'containing dot separated float' do
        it 'converts string to float' do
          expect('12.5'.to_num).to eq 12.5
          expect('-5.75'.to_num).to eq(-5.75)
        end
      end # containing float


      context 'containing comma separated float' do
        it 'converts string to float' do
          expect('12,5'.to_num).to eq 12.5
          expect('-5,75'.to_num).to eq(-5.75)
        end
      end # containing comma separated float


      context 'containing no valid value' do
        it 'returns nil' do
          expect('4a'.to_num).to be nil
          expect('4.5.3'.to_num).to be nil
          expect('nan'.to_num).to be nil
        end
      end # containing no valid value
    end # String


    context 'Fixnum' do
      it 'returns same Fixnum' do
        expect(12.to_num).to eq 12
        expect(-2.to_num).to eq(-2)
      end
    end # Fixnum


    context 'Float' do
      it 'returns same float' do
        expect(12.3.to_num).to eq 12.3
        expect(-2.5.to_num).to eq(-2.5)
      end
    end # Float


    context 'TrueClass' do
      it 'returns 1' do
        expect(true.to_num).to eq 1
      end
    end # TrueClass


    context 'FalseClass' do
      it 'returns -1' do
        expect(false.to_num).to eq(-1)
      end
    end # FalseClass


    context 'Array' do
      context 'Array can be joined to valid number' do
        it 'returns the joined number' do
          expect([1, 2, 3, 4].to_num).to eq 1234
          expect([1, '.', 5].to_num).to eq 1.5
          expect([1, 1.5, 6, 7].to_num).to eq 11.567
        end
      end # Array can be joined to valid number


      context 'Array can not be joined to valid number' do
        it 'returns nil' do
          expect(['1', 'as', 2].to_num).to be nil
          expect([1, 1.5, 2.5, 3].to_num).to be nil
        end
      end # Array can not be joined to valid number
    end # Array


    context 'Object without numerical representation' do
      it 'returns nil' do
        expect(Object.new.to_num).to be nil
      end
    end # Object without numerical representation
  end # #to_num
end # Numbers
