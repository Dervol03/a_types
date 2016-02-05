require 'decorators_helper'

module ATypes
  describe Boolean do
    subject { described_class.new('') }

    # it { is_expected.to respond_to(:true?)    }
    # it { is_expected.to respond_to(:false?)   }
    it { is_expected.to respond_to(:&)        }
    it { is_expected.to respond_to(:^)        }
    it { is_expected.to respond_to(:|)        }
    it { is_expected.to respond_to(:inspect)  }
    it { is_expected.to respond_to(:to_s)     }

    context 'for strings' do
      context 'option ruby_like is true' do
        it 'is truthy' do
          expect(described_class.new('', true)).not_to be false
          expect(described_class.new('', true)).to be_truthy
        end
      end # option ruby_like is true

      context 'option ruby_like is false' do
        context 'consists of a single character' do
          context 'character is one of: "y" "Y" "1"' do
            it 'is true' do
              expect(described_class.new('y')).to be true
              expect(described_class.new('Y')).to be true
              expect(described_class.new('1')).to be true
            end
          end # character is one of: "y" "Y" "1"

          context 'is any other character' do
            it 'is false' do
              expect(described_class.new('a')).to be false
              expect(described_class.new('2')).to be false
            end
          end # is any other character
        end # consists of a single character


        context 'consists of a multiple characters' do
          context 'word is one of: "yes" "Yes" "YES" "true" "True" "TRUE"' do
            it 'is true' do
              expect(described_class.new('yes')).to be true
              expect(described_class.new('Yes')).to be true
              expect(described_class.new('YES')).to be true
              expect(described_class.new('true')).to be true
              expect(described_class.new('True')).to be true
              expect(described_class.new('TRUE')).to be true
            end
          end # word is one of: "yes" "Yes" "YES" "true" "True" "TRUE"

          context 'is any other word' do
            it 'is false' do
              expect(described_class.new('no')).to be false
              expect(described_class.new('totally different')).to be false
            end
          end # if any other word
        end # consists of a multiple characters
      end # option ruby_like is false
    end # for strings


    context 'for Numerics' do
      context 'ruby_like options is false' do
        context 'value is less than 1' do
          it 'returns false' do
            expect(described_class.new(0)).to be false
            expect(described_class.new(-1)).to be false
          end
        end # value is less than one

        context 'value equals 1 or is bigger' do
          it 'returns true' do
            expect(described_class.new(1)).to be true
            expect(described_class.new(100)).to be true
          end
        end # value equals 1 or is bigger
      end # ruby_like options is false


      context 'ruby_like option is true' do
        context 'value less than 1' do
          it 'is truthy' do
            expect(described_class.new(0, true)).not_to be true
            expect(described_class.new(0, true)).to be_truthy
            expect(described_class.new(-1, true)).to be_truthy
          end
        end # value is 0

        context 'value equals 1 or is bigger' do
          it 'is truthy' do
            expect(described_class.new(1, true)).not_to be true
            expect(described_class.new(1, true)).to be_truthy
            expect(described_class.new(100, true)).to be_truthy
          end
        end # value equals 1 or is bigger
      end # ruby_like option is true
    end # for Numerics


    context 'for NilClass' do
      context 'ruby_like options is false' do
        it 'is false' do
          expect(described_class.new(nil)).to be false
        end
      end # ruby_like options is false

      context 'ruby_like options is true' do
        it 'is falsey' do
          expect(described_class.new(nil, true)).not_to be false
          expect(described_class.new(nil, true)).to be_falsey
        end
      end # ruby_like options is true
    end # for NilClass


    context 'for TruesClass' do
      context 'ruby_like options is false' do
        it 'is true' do
          expect(described_class.new(true)).to be true
        end
      end # ruby_like options is false

      context 'ruby_like options is true' do
        it 'is true' do
          expect(described_class.new(true, true)).to be true
        end
      end # ruby_like options is true

    end # for TruesClass


    context 'for FalseClass' do
      context 'ruby_like options is false' do
        it 'is false' do
          expect(described_class.new(false)).to be false
        end
      end # ruby_like options is false

      context 'ruby_like options is true' do
        it 'is false' do
          expect(described_class.new(false, true)).to be false
        end
      end # ruby_like options is true
    end # for FalseClass


    context 'for other objects' do
      context 'ruby_like options is false' do
        it 'is true' do
          expect(described_class.new(Object.new)).to be true
        end
      end # ruby_like options is true

      context 'ruby_like options is true' do
        it 'is falsey' do
          expect(described_class.new(Object.new, true)).not_to be true
          expect(described_class.new(Object.new, true)).to be_truthy
        end
      end # ruby_like options is true
    end # for other objects
  end # Boolean
end # ATypes
