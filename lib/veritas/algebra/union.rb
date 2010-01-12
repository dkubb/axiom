module Veritas
  module Algebra
    class Union < Relation
      include SetOperation
    end # class Union
  end # module Algebra
end # module Veritas

require 'veritas/algebra/union/set'
