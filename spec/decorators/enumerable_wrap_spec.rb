require 'decorators_helper'


describe ATypes::EnumerableWrap do
  it_behaves_like 'a delegating wrapper'


  describe '#filled?' do
    context 'element is nil' do
      it 'returns false' do
        expect(described_class.new(nil).filled?).to be false
      end
    end # element is nil

    context 'element is empty' do
      it 'returns true' do
        expect(described_class.new([]).filled?).to be false
      end
    end # element is empty

    context 'object has at least one element' do
      it 'returns true' do
        expect(described_class.new([1]).filled?).to be true
      end
    end # object has at least one element
  end # #filled?
end # Enumerable
