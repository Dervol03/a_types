require 'decorators_helper'

module ATypes
  describe Boolean do
    subject { described_class.new('y') }

    it { is_expected.to respond_to(:true?)    }
    it { is_expected.to respond_to(:false?)   }
    it { is_expected.to respond_to(:truthy?)    }
    it { is_expected.to respond_to(:falsey?)   }
    # it { is_expected.to respond_to(:&)        }
    # it { is_expected.to respond_to(:^)        }
    # it { is_expected.to respond_to(:|)        }
    # it { is_expected.to respond_to(:inspect)  }
    # it { is_expected.to respond_to(:to_s)     }

    describe '#true?' do
      context 'content is true' do
        it 'returns true' do
          instance = described_class.new(true)
          expect(instance.true?).to be true
        end
      end # content is true

      context 'content is false' do
        it 'returns false' do
          instance = described_class.new(false)
          expect(instance.true?).to be false
        end
      end # content is false
    end # #true?

    describe '#false?' do
      context 'content is false' do
        it 'returns true' do
          instance = described_class.new(false)
          expect(instance.false?).to be true
        end
      end # content is true

      context 'content is true' do
        it 'returns false' do
          instance = described_class.new(true)
          expect(instance.false?).to be false
        end
      end # content is false
    end # #false?


    describe '#truthy?' do
      context 'value attribute is on of: nil, false' do
        it 'returns false' do
          [nil, false].each do |neg|
            expect(described_class.new(neg).truthy?).to be false
          end
        end
      end # value attribute is on of: nil, false

      context 'value attribute is truthy object' do
        it 'returns true' do
          [Object.new, 0, 'false'].each do |pos|
            expect(described_class.new(pos).truthy?).to be true
          end
        end
      end # value attribute is truthy object
    end # #truthy?


    describe '#falsey?' do
      context 'value attribute is on of: nil, false' do
        it 'returns true' do
          [nil, false].each do |neg|
            expect(described_class.new(neg).falsey?).to be true
          end
        end
      end # value attribute is on of: nil, false

      context 'value attribute is truthy object' do
        it 'returns false' do
          [Object.new, 0, 'false'].each do |pos|
            expect(described_class.new(pos).falsey?).to be false
          end
        end
      end # value attribute is truthy object
    end # #falsey?


    describe '#truth' do
      context 'string is given' do
        context 'string consists of a singly character' do
          context 'string is one of: "y" "Y" "1" ' do
            it 'returns true' do
              %w(y Y 1).each do |char|
                expect(described_class.new(char).truth).to be true
              end
            end
          end # string is one of: "y" "Y" "1"

          context 'string is any other character' do
            it 'returns false' do
              expect(described_class.new('n').truth).to be false
            end
          end # string is any other character
        end # string consists of a singly character


        context 'string has multiple characters' do
          context 'string is on of: "yes" "Yes" "YES" "true" "True" "TRUE"' do
            it 'returns true' do
              %w(yes Yes YES true True TRUE).each do |word|
                expect(described_class.new(word).truth).to be true
              end
            end
          end # string is on of: "yes" "Yes" "YES" "true" "True" "TRUE"

          context 'string is any other word' do
            it 'returns false' do
              expect(described_class.new('false').truth).to be false
            end
          end # string is any other word
        end # string has multiple characters
      end # string is given


      context 'numeric is given' do
        context 'numeric is greather than 0' do
          it 'returns true' do
            [2, 100].each do |value|
              expect(described_class.new(value).truth).to be true
            end
          end
        end # numeric is greather than 0

        context 'numeric is smaller or equal to 0' do
          it 'returns false' do
            [0, -1, -10].each do |value|
              expect(described_class.new(value).truth).to be false
            end
          end
        end # numeric is smaller or equal to 0
      end # numeric is given


      context 'other object is given' do
        context 'object is nil' do
          it 'returns false' do
            expect(described_class.new(nil).truth).to be false
          end
        end # object is nil

        context 'object is false' do
          it 'returns false' do
            expect(described_class.new(false).truth).to be false
          end
        end # object is false


        context 'other object' do
          it 'returns true' do
            obj = Object.new
            expect(described_class.new(obj).truth).to be true
          end
        end # other object
      end # other object is given
    end # #truth
  end # Boolean
end # ATypes