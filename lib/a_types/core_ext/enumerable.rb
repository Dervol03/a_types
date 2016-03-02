# Adds some convenience methods to Ruby's standard Enumerable module
module Enumerable

  # Checks whether at least one element exists in the Enumerable.
  #
  # @return [true, false] depending on whether at least one element is present.
  def filled?
    !empty?
  end
end # Enumerable
