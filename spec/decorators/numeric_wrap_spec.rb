require 'spec_helper'

describe ATypes::NumericWrap do
  it_behaves_like 'a delegating wrapper'

  subject { described_class.new(Object.new) }

  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:to_num)  }


  describe '#to_num' do
    context 'wrapped object is String' do
      context 'containing fixnum' do
        it 'converts to Fixnum' do
          expect(described_class.new('12').to_num).to eq 12
          expect(described_class.new('-1').to_num).to eq(-1)
        end
      end # on containing fixnum


      context 'containing dot separated float' do
        it 'converts string to float' do
          expect(described_class.new('12.5').to_num).to  eq 12.5
          expect(described_class.new('-5.75').to_num).to eq(-5.75)
        end
      end # containing float


      context 'containing comma separated float' do
        it 'converts string to float' do
          expect(described_class.new('12,5').to_num).to   eq 12.5
          expect(described_class.new('-5,75').to_num).to  eq(-5.75)
        end
      end # containing comma separated float


      context 'containing no valid value' do
        it 'returns nil' do
          expect(described_class.new('4a').to_num).to     be nil
          expect(described_class.new('4.5.3').to_num).to  be nil
          expect(described_class.new('nan').to_num).to    be nil
        end
      end # containing no valid value
    end # wrapped object is String


    context 'wrapped object is of TrueClass' do
      it 'returns 1' do
        expect(described_class.new(true).to_num).to eq 1
      end
    end # wrapped object is of TrueClass


    context 'wrapped object is of FalseClass' do
      it 'returns -1' do
        expect(described_class.new(false).to_num).to eq(-1)
      end
    end # wrapped object is of TrueClass


    context 'wrapped object is an Array' do
      context 'Array can be joined to valid number' do
        it 'returns the joined number' do
          expect(described_class.new([1, 2, 3, 4]).to_num).to   eq 1234
          expect(described_class.new([1, '.', 5]).to_num).to    eq 1.5
          expect(described_class.new([1, 1.5, 6, 7]).to_num).to eq 11.567
        end
      end # Array can be joined to valid number


      context 'Array can not be joined to valid number' do
        it 'returns nil' do
          expect(described_class.new(['1', 'as', 2]).to_num).to   be nil
          expect(described_class.new([1, 1.5, 2.5, 3]).to_num).to be nil
        end
      end # Array can not be joined to valid number
    end # Array
  end # #to_num


  describe '.try_convert' do
    context 'object can be converted to Fixnum' do
      it 'converts object to fixnum' do
        expect(described_class.try_convert(3)).to     eq 3
        expect(described_class.try_convert(-5)).to    eq(-5)
        expect(described_class.try_convert('12')).to  eq 12
        expect(described_class.try_convert(true)).to  eq 1
        expect(described_class.try_convert(false)).to eq(-1)
      end
    end # object can be converted to Fixnum

    context 'object can be converted to Float' do
      it 'converts object to Float' do
        expect(described_class.try_convert(1.5)).to     eq 1.5
        expect(described_class.try_convert(-3.6)).to    eq(-3.6)
        expect(described_class.try_convert('12.5')).to  eq 12.5
        expect(described_class.try_convert('-3,6')).to  eq(-3.6)
      end
    end # object can be converted to Float


    context 'object can not be converted to any numeric' do
      it 'returns nil' do
        expect(described_class.try_convert('hello')).to       be nil
        expect(described_class.try_convert([1, 1.3, 1.4])).to be nil
        expect(described_class.try_convert(a: 1)).to        eq nil
      end
    end # object can not be converted to any numeric
  end # .try_convert
end # ATypes::NumericWrap
