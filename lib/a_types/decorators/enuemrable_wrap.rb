module ATypes
  # Adds enumerable convenience methods to any object, preserving its original
  # behavior.
  class EnumerableWrap < Wrapper
    # Returns true if this objects contains any actual content.
    #
    # @return [true, false] depending on whether this object has content.
    def filled?
      !blank?
    end


    # Checks whether the object is nil or empty.
    #
    # @return [true, false] if object is empty or nil.
    def blank?
      if content.respond_to?(:empty?)
        content.empty?
      else
        content.nil?
      end
    end
  end # EnumerableWrap
end # ATypes
