module Veritas
  module Logic
    class Connective < Expression
      include AbstractClass

      module Methods; end

    end # class Connective
  end # module Logic
end # module Veritas

require 'veritas/logic/connective/binary'

require 'veritas/logic/connective/conjunction'
require 'veritas/logic/connective/disjunction'
require 'veritas/logic/connective/complement'

Veritas::Logic::Expression.class_eval { include Veritas::Logic::Connective::Methods }
