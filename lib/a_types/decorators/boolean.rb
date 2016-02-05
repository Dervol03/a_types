#
module ATypes
  # A decorator to any object providing Boolean behavior. In comparisons, it
  # always returns the real true or false instance to avoid ambiguity. By
  # default, it will handle special values for different object classes, like
  # certain strings, e.g. transforming the *'true'* to an instance of the
  # TrueClass. This behavior may be turned off, though, in which case the
  # standard Ruby evaluation of truthy and falsey will be respected.
  class Boolean

    # Boolean class methods (all private).
    module ClassMethods
      private

      def convert_string(obj)
        %w(y Y 1 yes Yes YES true True TRUE).include?(obj)
      end

      def convert_numeric(value)
        value > 0
      end

      alias convert_fixnum convert_numeric
      alias convert_integer convert_numeric
      alias convert_bignum convert_numeric
      alias convert_float convert_numeric
    end

    extend ClassMethods

    # @param [Object] obj to be decorated as Boolean
    # @param [Boolean] ruby_like whether the value shall be converted according
    #                  to Ruby's truthy definition.
    # @return [true] if obj can be converted truthy
    # @return [false] otherwise
    def self.new(obj, ruby_like = false)
      strategy = "convert_#{obj.class.name.downcase}"

      if ruby_like
        obj
      else
        respond_to?(strategy, true) ? send(strategy, obj) : !!obj
      end

    end








  end # Boolean
end # ATypes
