# Adds enumerable convenience methods to any object, preserving its original
# behavior.
class EnumerableWrap < SimpleDelegator
  # @return [Object] original object.
  def content
    __getobj__
  end


  # Returns true if this objects contains any actual content.
  #
  # @return [true, false] depending on whether this object has content.
  def filled?
    content.respond_to?(:empty?) && !content.empty?
  end


end # EnumerableWrap
