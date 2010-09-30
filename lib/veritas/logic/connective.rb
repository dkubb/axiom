module Veritas
  module Logic

    # Abstract base class for logical connectives
    class Connective < Expression
      include AbstractClass
    end # class Connective
  end # module Logic
end # module Veritas

require 'veritas/logic/connective/binary'

require 'veritas/logic/connective/conjunction'
require 'veritas/logic/connective/disjunction'
require 'veritas/logic/connective/negation'
