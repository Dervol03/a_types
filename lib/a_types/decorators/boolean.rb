#
module ATypes
  # A decorator to any object providing Boolean behavior. In comparisons, it
  # always returns the real true or false instance to avoid ambiguity. By
  # default, it will handle special values for different object classes, like
  # certain strings, e.g. transforming the *'true'* to an instance of the
  # TrueClass. This behavior may be turned off, though, in which case the
  # standard Ruby evaluation of truthy and falsey will be respected.
  class Boolean
    attr_reader :value

    # @param [Object] obj to be decorated as Boolean.
    def initialize(obj)
      @value = obj
    end


    # Extracts the truth from this Boolean's value according to the following
    # rules:
    # - for any kind of numeric: values above *0* are *true*, others false.
    #
    # - for strings: any string equal to either of the following
    #     ["y", "Y", 1, "yes", "Yes", "YES", "true", "True", "TRUE"]
    #   will be *true*, otherwise false.
    #
    # - any other object will be transformed to a hard boolean according Ruby's
    #   default truthy evaluation.
    def truth
      @truth ||= extract_truth(@value)
    end


    # @return [true, false] depending on whether the content interprets to true.
    def true?
      truth
    end


    # @return [true, false] depending on whether the content interprets to
    #                       false.
    def false?
      !truth
    end


    # @return [true, false] whether the content is truthy according to Ruby's
    #                       rules.
    def truthy?
      !!value
    end


    # @return [true, false] whether the content is falsey according to Ruby's
    #                       rules.
    def falsey?
      !value
    end


    # Will operate a logical AND with other, based on this Boolean's #truth
    # interpretation. It will therefore handle Ruby's native booleans and the
    # Boolean instances in the very same way. Otherwise, the logic abides Ruby's
    # default truthy interpretation.
    #
    # @example
    #   Boolean.new(true) & Boolean.new(true) # => true
    #   Boolean.new('y')  & "hello"           # => true
    #   Boolean.new('y')  & nil               # => false
    #
    # @param [Boolean, true, false, Object] other to logically combine with this
    #                                       Boolean.
    # @return [true, false] result of logical AND.
    def &(other)
      other_value = other.respond_to?(:truth) ? other.truth : other
      truth & other_value
    end


    # Will operate a logical OR with other, based on this Boolean's #truth
    # interpretation. It will therefore handle Ruby's native booleans and the
    # Boolean instances in the very same way. Otherwise, the logic abides Ruby's
    # default truthy interpretation.
    #
    # @example
    #   Boolean.new(true)   | Boolean.new(true) # => true
    #   Boolean.new('y')    | "hello"           # => true
    #   Boolean.new('y')    | nil               # => true
    #   Boolean.new(false)  | nil              # => false
    #
    # @param [Boolean, true, false, Object] other to logically combine with this
    #                                       Boolean.
    # @return [true, false] result of logical OR.
    def |(other)
      other_value = other.respond_to?(:truth) ? other.truth : other
      truth | other_value
    end


    # Will operate a logical XOR with other, based on this Boolean's #truth
    # interpretation. It will therefore handle Ruby's native booleans and the
    # Boolean instances in the very same way. Otherwise, the logic abides Ruby's
    # default truthy interpretation.
    #
    # @example
    #   Boolean.new(true)   ^ Boolean.new(true) # => false
    #   Boolean.new('y')    ^ "hello"           # => true
    #   Boolean.new('y')    ^ nil               # => true
    #   Boolean.new(false)  ^ nil              # => false
    #
    # @param [Boolean, true, false, Object] other to logically combine with this
    #                                       Boolean.
    # @return [true, false] result of logical OR.
    def ^(other)
      other_value = other.respond_to?(:truth) ? other.truth : other
      truth ^ other_value
    end


    # @example
    #   Boolean.new('y').to_s   # => "true"
    #
    # @return [String] string representation of this Boolean's #truth
    #                  interpretation.
    def to_s
      truth.to_s
    end
    alias inspect to_s


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


    def extract_truth(obj)
      strategy = "convert_#{obj.class.name.downcase}"
      @truth = respond_to?(strategy, true) ? send(strategy, obj) : !!obj
    end


  end # Boolean
end # ATypes
