require_relative 'wrapper'

module ATypes
  # A decorator to any object providing Boolean behavior. In comparisons, it
  # always returns the real true or false instance to avoid ambiguity. By
  # default, it will handle special values for different object classes, like
  # certain strings, e.g. transforming the *'true'* to an instance of the
  # TrueClass. This behavior may be turned off, though, in which case the
  # standard Ruby evaluation of truthy and falsey will be respected.
  class BooleanWrap < Wrapper
    # Extracts the truth from this BooleanWrap's value according to the
    # following rules:
    # - for any kind of numeric: values above *0* are *true*, others false.
    #
    # - for strings: any string equal to either of the following
    #     ["y", "Y", "1", "yes", "Yes", "YES", "true", "True", "TRUE"]
    #   will be *true*, any string equal to either of these
    #     ["n", "N", "-1", "no", "No", "NO", "false", "False", "FALSE"]
    #   will be *false*.
    #
    # - any other object will be transformed to a hard boolean according Ruby's
    #   default truthy evaluation.
    #
    # @return [true, false, nil] depending on whether the object may be
    #   converted and which value it contains.
    def to_bool
      @truth ||= extract_truth(content)
    end
    alias truth to_bool
    alias to_b to_bool


    # Will try to convert this BooleanWrap according to the rules of {#to_bool},
    # however, it will raise an ArgumentError if conversion fails.
    #
    # @return [true, false, nil] depending on whether the object may be
    #   converted and which value it contains.
    # @see #to_bool
    def to_bool!
      error_msg = ">#{content}< can't be interpreted as boolean!"
      converted = to_bool

      fail(ArgumentError, error_msg) if converted.nil?
      converted
    end


    # @return [true, false] depending on whether the content interprets to true.
    def true?
      to_bool
    end


    # @return [true, false] depending on whether the content interprets to
    #                       false.
    def false?
      !to_bool
    end


    # @return [true, false] whether the content is truthy according to Ruby's
    #                       rules.
    def truthy?
      # content can literally be ANYTHING, thus double negation should be the
      # tool of choice here.
      !!content
    end


    # @return [true, false] whether the content is falsey according to Ruby's
    #                       rules.
    def falsey?
      !content
    end


    # Will operate a logical AND with other, based on this BooleanWrap's
    # {#to_bool} interpretation. It will therefore handle Ruby's native booleans
    # and the BooleanWrap instances in the very same way. Otherwise, the logic
    # abides Ruby's default truthy interpretation.
    #
    # @example
    #   BooleanWrap.new(true) & BooleanWrap.new(true) # => true
    #   BooleanWrap.new('y')  & "hello"           # => true
    #   BooleanWrap.new('y')  & nil               # => false
    #
    # @param [BooleanWrap, true, false, Object] other to logically combine with
    #   this BooleanWrap.
    # @return [true, false] result of logical AND.
    def &(other)
      other_value = other.respond_to?(:truthy?) ? other.truthy? : other
      to_bool & other_value
    end


    # Will operate a logical OR with other, based on this BooleanWrap's
    # {#to_bool} interpretation. It will therefore handle Ruby's native booleans
    # and the BooleanWrap instances in the very same way. Otherwise, the logic
    # abides Ruby's default truthy interpretation.
    #
    # @example
    #   BooleanWrap.new(true)   | BooleanWrap.new(true) # => true
    #   BooleanWrap.new('y')    | "hello"           # => true
    #   BooleanWrap.new('y')    | nil               # => true
    #   BooleanWrap.new(false)  | nil              # => false
    #
    # @param [BooleanWrap, true, false, Object] other to logically combine with
    #   this BooleanWrap.
    # @return [true, false] result of logical OR.
    def |(other)
      other_value = other.respond_to?(:truthy?) ? other.truthy? : other
      to_bool | other_value
    end


    # Will operate a logical XOR with other, based on this BooleanWrap's
    # {#to_bool} interpretation. It will therefore handle Ruby's native booleans
    # and the BooleanWrap instances in the very same way. Otherwise, the logic
    # abides Ruby'sdefault truthy interpretation.
    #
    # @example
    #   BooleanWrap.new(true)   ^ BooleanWrap.new(true) # => false
    #   BooleanWrap.new('y')    ^ "hello"           # => true
    #   BooleanWrap.new('y')    ^ nil               # => true
    #   BooleanWrap.new(false)  ^ nil              # => false
    #
    # @param [BooleanWrap, true, false, Object] other to logically combine with
    #   this BooleanWrap.
    # @return [true, false] result of logical OR.
    def ^(other)
      other_value = other.respond_to?(:truthy?) ? other.truthy? : other
      to_bool ^ other_value
    end


    # @example
    #   BooleanWrap.new('y').to_s   # => "true"
    #
    # @return [String] string representation of this BooleanWrap's {#to_bool}
    #   interpretation.
    def to_s
      to_bool.to_s
    end
    alias inspect to_s


    # Will try to convert given object to a boolean value according to
    # {#to_bool!}. If this fails, it will return nil.
    #
    # @param [Object] source to be converted to a boolean value.
    # @return [true, false, nil] depending on whether and how the object is
    #                            convertible
    def self.try_convert(source)
      new(source).to_bool!
    end

    private

    def convert_string(obj)
      if %w(y Y 1 yes Yes YES true True TRUE).include?(obj)
        true
      elsif %w(n N -1 no No NO false False FALSE).include?(obj)
        false
      end
    end

    def convert_numeric(value)
      value > 0
    end

    alias convert_fixnum      convert_numeric
    alias convert_integer     convert_numeric
    alias convert_bignum      convert_numeric
    alias convert_float       convert_numeric
    alias convert_bigdecimal  convert_numeric


    def extract_truth(obj)
      strategy = "convert_#{obj.class.name.downcase}"
      @truth = respond_to?(strategy, true) ? send(strategy, obj) : truthy?
    end


  end # BooleanWrap
end # ATypes
