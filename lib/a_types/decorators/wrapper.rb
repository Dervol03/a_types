module ATypes
  # Parent class of all wrappers.
  class Wrapper < SimpleDelegator
    # @return [Object] original object.
    def content
      __getobj__
    end
  end # Wrapper
end
