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
  it {  is_expected.to respond_to(:to_bool) }

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
  end
end