# Adds #blank? if not already defined and #filled? as opposite method.
class Object
  unless method_defined?(:blank?)
    # Checks whether the object is nil or has no content.
    #
    # @return [true, false] depending on whether it is nil or empty.
    def blank?
      respond_to?(:empty?) ? empty? : nil?
    end
  end

  # Checks whether the object has any content.
  # @return [true, false] depending on whether any content is present.
  def filled?
    !blank?
  end
end
