require 'decorators_helper'

module ATypes
  describe BooleanWrap do
    subject { described_class.new('y') }

    let(:positive_bool){ BooleanWrap.new(true)  }
    let(:negative_bool){ BooleanWrap.new(false) }

    it { is_expected.to respond_to(:true?)    }
    it { is_expected.to respond_to(:false?)   }
    it { is_expected.to respond_to(:truthy?)    }
    it { is_expected.to respond_to(:falsey?)   }
    it { is_expected.to respond_to(:&)        }
    it { is_expected.to respond_to(:|)        }
    it { is_expected.to respond_to(:^)        }
    it { is_expected.to respond_to(:inspect)  }
    it { is_expected.to respond_to(:to_s)     }

    it 'it delegates any method of the wrapped object' do
      obj = Object.new
      expect(obj).to receive(:native_method)

      wrapped_obj = BooleanWrap.new(obj)
      wrapped_obj.native_method
    end

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
                expect(described_class.new(char).to_bool).to be true
              end
            end
          end # string is one of: "y" "Y" "1"

          context 'string is any other character' do
            it 'returns false' do
              expect(described_class.new('n').to_bool).to be false
            end
          end # string is any other character
        end # string consists of a singly character


        context 'string has multiple characters' do
          context 'string is on of: "yes" "Yes" "YES" "true" "True" "TRUE"' do
            it 'returns true' do
              %w(yes Yes YES true True TRUE).each do |word|
                expect(described_class.new(word).to_bool).to be true
              end
            end
          end # string is on of: "yes" "Yes" "YES" "true" "True" "TRUE"

          context 'string is any other word' do
            it 'returns false' do
              expect(described_class.new('false').to_bool).to be false
            end
          end # string is any other word
        end # string has multiple characters
      end # string is given


      context 'numeric is given' do
        context 'numeric is greather than 0' do
          it 'returns true' do
            [2, 100].each do |value|
              expect(described_class.new(value).to_bool).to be true
            end
          end
        end # numeric is greather than 0

        context 'numeric is smaller or equal to 0' do
          it 'returns false' do
            [0, -1, -10].each do |value|
              expect(described_class.new(value).to_bool).to be false
            end
          end
        end # numeric is smaller or equal to 0
      end # numeric is given


      context 'other object is given' do
        context 'object is nil' do
          it 'returns false' do
            expect(described_class.new(nil).to_bool).to be false
          end
        end # object is nil

        context 'object is false' do
          it 'returns false' do
            expect(described_class.new(false).to_bool).to be false
          end
        end # object is false


        context 'other object' do
          it 'returns true' do
            obj = Object.new
            expect(described_class.new(obj).to_bool).to be true
          end
        end # other object
      end # other object is given
    end # #truth


    describe '#&' do
      context 'other has #truth understanding' do
        it 'performs logical AND operation with other' do
          expect(positive_bool & BooleanWrap.new(true)).to be true
          expect(positive_bool & BooleanWrap.new(false)).to be false

          expect(negative_bool & BooleanWrap.new(true)).to be false
          expect(negative_bool & BooleanWrap.new(false)).to be false
        end
      end # other has #truth understanding


      context 'other is native boolean' do
        it 'performs logical AND with native boolean' do
          expect(positive_bool & true).to be true
          expect(positive_bool & false).to be false

          expect(negative_bool & true).to be false
          expect(negative_bool & false).to be false
        end
      end # other is native boolean

      context 'other is non boolean object' do
        it 'performs logical AND according to Ruby truthy behavior' do
          expect(positive_bool & 'one').to be true
          expect(positive_bool & -1).to be true
          expect(positive_bool & nil).to be false

          expect(negative_bool & 'one').to be false
          expect(negative_bool & -1).to be false
          expect(negative_bool & nil).to be false
        end
      end # other is non boolean object
    end # #&


    describe '#|' do
      context 'other has #truth understanding' do
        it 'performs logical OR operation with other' do
          expect(positive_bool | BooleanWrap.new(true)).to be true
          expect(positive_bool | BooleanWrap.new(false)).to be true

          expect(negative_bool | BooleanWrap.new(true)).to be true
          expect(negative_bool | BooleanWrap.new(false)).to be false
        end
      end # other has #truth understanding


      context 'other is native boolean' do
        it 'performs logical OR with native boolean' do
          expect(positive_bool | true).to be true
          expect(positive_bool | false).to be true

          expect(negative_bool | true).to be true
          expect(negative_bool | false).to be false
        end
      end # other is native boolean

      context 'other is non boolean object' do
        it 'performs logical OR according to Ruby truthy behavior' do
          expect(positive_bool | 'one').to be true
          expect(positive_bool | -1).to be true
          expect(positive_bool | nil).to be true

          expect(negative_bool | 'one').to be true
          expect(negative_bool | -1).to be true
          expect(negative_bool | nil).to be false
        end
      end # other is non boolean object
    end # #|


    describe '#^' do
      context 'other has #truth understanding' do
        it 'performs logical XOR operation with other' do
          expect(positive_bool ^ BooleanWrap.new(true)).to be false
          expect(positive_bool ^ BooleanWrap.new(false)).to be true

          expect(negative_bool ^ BooleanWrap.new(true)).to be true
          expect(negative_bool ^ BooleanWrap.new(false)).to be false
        end
      end # other has #truth understanding


      context 'other is native boolean' do
        it 'performs logical XOR with native boolean' do
          expect(positive_bool ^ true).to be false
          expect(positive_bool ^ false).to be true

          expect(negative_bool ^ true).to be true
          expect(negative_bool ^ false).to be false
        end
      end # other is native boolean

      context 'other is non boolean object' do
        it 'performs logical XOR according to Ruby truthy behavior' do
          expect(positive_bool ^ 'one').to be false
          expect(positive_bool ^ -1).to be false
          expect(positive_bool ^ nil).to be true

          expect(negative_bool ^ 'one').to be true
          expect(negative_bool ^ -1).to be true
          expect(negative_bool ^ nil).to be false
        end
      end # other is non boolean object
    end # #^


    describe '#to_s' do
      it 'retruns the #truth interpretation as string' do
        expect(positive_bool.to_s).to eq 'true'
        expect(negative_bool.to_s).to eq 'false'
      end
    end # #to_s
  end # BooleanWrap
end # ATypes
