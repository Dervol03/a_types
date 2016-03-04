require 'core_ext_helper'

describe Object do
  describe '#blank?' do
    context 'object is nil' do
      it 'returns true' do
        expect(nil.blank?).to be true
      end
    end # object is nil

    context 'object has no #empty? check' do
      it 'returns true' do
        expect(true.blank?).to be false
      end
    end # object has no #empty? check


    context 'object has an #empty? check' do
      context 'object has no content' do
        it 'returns true' do
          expect(''.blank?).to be true
          expect([].blank?).to be true
          expect({}.blank?).to be true
        end
      end # object has no content


      context 'has some content' do
        it 'returns false' do
          expect('subject'.blank?).to be false
          expect([1].blank?).to be false
          expect({a: 1, b: 2}.blank?).to be false
        end
      end # has some content
    end # object has an #empty? check
  end # #blank?


  describe '#filled?' do
    context 'object is nil' do
      it 'returns false' do
        expect(nil.filled?).to be false
      end
    end # object is nil

    context 'object has no #empty? check' do
      it 'returns true' do
        expect(true.filled?).to be true
      end
    end # object has no #empty? check


    context 'object has an #empty? check' do
      context 'object has no content' do
        it 'returns false' do
          expect(''.filled?).to be false
          expect([].filled?).to be false
          expect({}.filled?).to be false
        end
      end # object has no content


      context 'has some content' do
        it 'returns true' do
          expect('subject'.filled?).to be true
          expect([1].filled?).to be true
          expect({a: 1, b: 2}.filled?).to be true
        end
      end # has some content
    end # object has an #empty? check
  end # #filled?
end # Object
