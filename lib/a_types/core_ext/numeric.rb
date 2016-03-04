# Provides convenience methods to convert objects into number representations
# . Most prominently #to_num method.
class Object
  # Will try to convert this Object into a number. Returns nil of this fails.
  #
  # @return [Numeric, nil] depending on whether conversion to number is
  # possible.
  def to_num
    strategy = "convert_#{self.class.name.downcase}_to_num"
    respond_to?(strategy, true) ? send(strategy) : nil
  end


  private

  def convert_string_to_num
    case self
    when /^-?\d+$/ then
      to_i
    when /^-?\d+[,.]\d+$/ then
      sub(',', '.').to_f
    end
  end


  def convert_numeric_to_num
    self
  end
  alias convert_integer_to_num  convert_numeric_to_num
  alias convert_fixnum_to_num   convert_numeric_to_num
  alias convert_float_to_num    convert_numeric_to_num
  alias convert_bignum_to_num   convert_numeric_to_num


  def convert_trueclass_to_num
    1
  end


  def convert_falseclass_to_num
    -1
  end


  def convert_array_to_num
    join.to_num
  end


end # Object
