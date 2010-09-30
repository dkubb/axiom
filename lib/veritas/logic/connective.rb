module Veritas
  module Logic
    class Connective < Expression
      include AbstractClass
    end # class Connective
  end # module Logic
end # module Veritas

require 'veritas/logic/connective/binary'

require 'veritas/logic/connective/conjunction'
require 'veritas/logic/connective/disjunction'
require 'veritas/logic/connective/negation'
