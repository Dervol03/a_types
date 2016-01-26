require 'spec_helper'

require 'a_types/monkey/boolean'

describe 'Kernel' do
  # it 'has new type cast Boolean' do
  #   expect(Kernel).to respond_to(:Boolean)
  # end
  #
  # it 'casts Numeric 0 to false' do
  #   expect(Boolean(0)).to be false
  # end
  #
  # it 'casts Numerics smaller than 0 to false' do
  #   expect(Boolean(-1)).to be false
  #   expect(Boolean(-100)).to be false
  # end
  #
  # it 'casts Numerics greater than 0 to true' do
  #   expect(Boolean(1)).to be true
  #   expect(Boolean(100)).to be true
  # end

end


describe Numeric do
  it{ is_expected.to respond_to(:to_bool)   }
  it{ is_expected.to respond_to(:to_b)      }
  it{ is_expected.to respond_to(:to_bool!)  }
  it{ is_expected.to respond_to(:to_b!)     }

  describe '#to_bool' do
    context 'is 0' do
      it 'returns false' do
        expect(0.to_bool).to be false
      end
    end# is 0

    context 'is smaller than 0' do
      it 'returns false' do
        expect((-1).to_bool).to be false
        expect((-100).to_bool).to be false
      end
    end# is greater than 0

    context 'is greater than 0' do
      it 'returns true' do
        expect((1).to_bool).to be true
        expect((100).to_bool).to be true
      end
    end# is greater than 0
  end# #to_bool

  describe '#to_bool!' do
    context 'is 0' do
      it 'returns false' do
        expect(0.to_bool!).to be false
      end
    end# is 0

    context 'is smaller than 0' do
      it 'returns false' do
        expect((-1).to_bool!).to be false
        expect((-100).to_bool!).to be false
      end
    end# is greater than 0

    context 'is greater than 0' do
      it 'returns true' do
        expect((1).to_bool!).to be true
        expect((100).to_bool!).to be true
      end
    end# is greater than 0
  end# #to_bool
end# Numeric


describe String do
  it{ is_expected.to respond_to(:to_bool)   }
  it{ is_expected.to respond_to(:to_b)      }

  it{ is_expected.to respond_to(:to_bool!)  }
  it{ is_expected.to respond_to(:to_b!)     }


  describe '#to_bool' do
    context 'consists of a single character' do
      context 'character is one of: "y" "Y" "1"' do
        it 'converts it to true' do
          expect('y'.to_bool).to be true
          expect('Y'.to_bool).to be true
          expect('1'.to_bool).to be true
        end
      end # character is on of: y Y 1

      context 'is any other character' do
        it 'converts it to false' do
          expect('a'.to_bool).to be false
          expect('2'.to_bool).to be false
        end
      end
    end # consists of a single character


    context 'consists of a multiple characters' do
      context 'word is one of: "yes" "Yes" "YES" "true" "True" "TRUE"' do
        it 'converts it to true' do
          expect('yes'.to_bool).to be true
          expect('Yes'.to_bool).to be true
          expect('YES'.to_bool).to be true
          expect('true'.to_bool).to be true
          expect('True'.to_bool).to be true
          expect('TRUE'.to_bool).to be true
        end
      end # word is in "yes" "Yes" "YES" "1" "true" "True" "TRUE"

      context 'is any other word' do
        it 'converts it to false' do
          expect('no'.to_bool).to be false
          expect('totally different'.to_bool).to be false
        end
      end# is any other word
    end # consists of a multiple characters
  end # '#to_bool'


  describe '#to_bool!' do
    context 'consists of a single character' do
      context 'character is one of: "y" "Y" "1"' do
        it 'converts it to true' do
          expect('y'.to_bool!).to be true
          expect('Y'.to_bool!).to be true
          expect('1'.to_bool!).to be true
        end
      end # character is on of: y Y 1


      context 'character is one of: "n" "N" "0" ""' do
        it 'converts it to false' do
          expect('n'.to_bool!).to be false
          expect('N'.to_bool!).to be false
          expect('0'.to_bool!).to be false
          expect(''.to_bool!).to be false
        end
      end # character is one of: "n" "N" "0" ""

      context 'is any other character' do
        it 'raises Argument Error' do
          expect{ 'a'.to_bool! }.to raise_error(ArgumentError)
          expect{ '2'.to_bool! }.to raise_error(ArgumentError)
        end
      end
    end # consists of a single character


    context 'consists of a multiple characters' do
      context 'word is one of: "yes" "Yes" "YES" true" "True" "TRUE"' do
        it 'converts it to true' do
          expect('yes'.to_bool!).to be true
          expect('Yes'.to_bool!).to be true
          expect('YES'.to_bool!).to be true
          expect('true'.to_bool!).to be true
          expect('True'.to_bool!).to be true
          expect('TRUE'.to_bool!).to be true
        end
      end # word is in "yes" "Yes" "YES" "1" "true" "True" "TRUE"

      context 'word is one of: "no" "No" "NO" "false" "False" "FALSE"' do
        it 'converts it to false' do
          expect('no'.to_bool!).to be false
          expect('No'.to_bool!).to be false
          expect('NO'.to_bool!).to be false
          expect('false'.to_bool!).to be false
          expect('False'.to_bool!).to be false
          expect('FALSE'.to_bool!).to be false
        end
      end # word is one of: "no" "No" "NO" "false" "False" "FALSE"

      context 'is any other word' do
        it 'raises Argument Error' do
          expect{ 'nope'.to_bool! }.to raise_error(ArgumentError)
          expect{ 'multi words'.to_bool! }.to raise_error(ArgumentError)
        end
      end# is any other word
    end # consists of a multiple characters
  end # '#to_bool'
end# String


describe Object do
  it{ is_expected.to respond_to(:to_bool)   }
  it{ is_expected.to respond_to(:to_b)      }
  it{ is_expected.to respond_to(:to_bool!)  }
  it{ is_expected.to respond_to(:to_b!)     }

  describe '#to_bool' do
    it 'returns true' do
      expect(Object.new.to_bool).to be true
    end
  end # '#to_bool'

  describe '#to_bool!' do
    it 'returns true' do
      expect(Object.new.to_bool!).to be true
    end
  end # '#to_bool!'
end # Object


describe NilClass do
  it 'should respond to #to_bool' do
    expect(nil).to respond_to(:to_bool)
  end

  it 'should respond to #to_b' do
    expect(nil).to respond_to(:to_b!)
  end

  it 'should respond to #to_bool!' do
    expect(nil).to respond_to(:to_bool!)
  end

  it 'should respond to #to_b!' do
    expect(nil).to respond_to(:to_b!)
  end

  describe '#to_bool' do
    it 'returns false' do
      expect(nil.to_bool).to be false
    end
  end # '#to_bool'

  describe '#to_bool!' do
    it 'returns false' do
      expect(nil.to_bool!).to be false
    end
  end # '#to_bool!'
end # NilClass


describe TrueClass do
  it 'should respond to #to_bool' do
    expect(true).to respond_to(:to_bool)
  end

  it 'should respond to #to_b' do
    expect(true).to respond_to(:to_b!)
  end

  it 'should respond to #to_bool!' do
    expect(true).to respond_to(:to_bool!)
  end

  it 'should respond to #to_b!' do
    expect(true).to respond_to(:to_b!)
  end

  describe '#to_bool' do
    it 'returns false' do
      expect(true.to_bool).to be true
    end
  end # '#to_bool'

  describe '#to_bool!' do
    it 'returns false' do
      expect(true.to_bool!).to be true
    end
  end # '#to_bool!'
end # TrueClass


describe FalseClass do
  it 'should respond to #to_bool' do
    expect(false).to respond_to(:to_bool)
  end

  it 'should respond to #to_b' do
    expect(false).to respond_to(:to_b!)
  end

  it 'should respond to #to_bool!' do
    expect(false).to respond_to(:to_bool!)
  end

  it 'should respond to #to_b!' do
    expect(false).to respond_to(:to_b!)
  end

  describe '#to_bool' do
    it 'returns false' do
      expect(false.to_bool).to be false
    end
  end # '#to_bool'

  describe '#to_bool!' do
    it 'returns false' do
      expect(false.to_bool!).to be false
    end
  end # '#to_bool!'
end # TrueClass