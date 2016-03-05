require_relative 'wrapper'

module ATypes
  # Adds numeric methods to any wrapped object.
  class NumericWrap < Wrapper
    # Returns the numeric value of this wrapped object. Depending on its class,
    # different strategies will be applied in the course:
    # - Strings will be parsed for their content and return nil if it does not
    #   match any number
    # - true/false will return 1 / -1
    # - Numerics will return themselves
    # - Other objects will simply return nil
    #
    # @return [Fixnum, Float, nil] the number that could be interpreted from the
    #   wrapped object.
    def to_num
      strategy = "convert_#{content.class.name.downcase}"
      respond_to?(strategy, true) ? send(strategy, content) : nil
    end


    # Tries to convert the given object to a numerical value, according to the
    # rules of {#to_num}. Returns nil if no conversion is possible.
    #
    # @param [Object] source to be converted
    # @return [Fixnum, Float, nil] the result of the conversion to a numeric
    #   value.
    def self.try_convert(source)
      new(source).to_num
    end

    private

    def convert_string(content)
      if content =~ Matchers::FIXNUM
        content.to_i
      elsif content =~ Matchers::FLOAT
        content.sub(',', '.').to_f
      end
    end


    def convert_trueclass(_content)
      1
    end


    def convert_falseclass(_content)
      -1
    end


    def convert_array(content)
      convert_string(content.join)
    end


    def convert_fixnum(content)
      content
    end
    alias convert_bignum      convert_fixnum
    alias convert_numeric     convert_fixnum
    alias convert_integer     convert_fixnum
    alias convert_float       convert_fixnum
    alias convert_bigdecimal  convert_fixnum
  end # NumericWrap
end # ATypes
