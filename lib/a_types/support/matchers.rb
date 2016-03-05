module ATypes
  # Provides common matchers
  module Matchers
    # Regular expression representing a Fixnum.
    FIXNUM  = /^-?\d+$/
    # Regular expression matching any float, independently from the separating
    # character.
    FLOAT   = /^-?\d+[,.]\d+$/
  end # Matchers
end
