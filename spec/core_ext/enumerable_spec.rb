require 'core_ext_helper'

describe Enumerable do
  class EnumTestClass
    include Enumerable
  end

  subject { EnumTestClass.new }

  it { is_expected.to respond_to(:filled?) }

  describe '#filled?' do
    context 'is empty' do
      before(:each){ allow(subject).to receive(:empty?).and_return(true) }

      it 'returns false' do
        expect(subject.filled?).to be false
      end
    end # is empty

    context 'has at least one element' do
      before(:each){ allow(subject).to receive(:empty?).and_return(false) }

      it 'returns true' do
        expect(subject.filled?).to be true
      end
    end # has at least one element
  end # #filled?
end # Enumerable
