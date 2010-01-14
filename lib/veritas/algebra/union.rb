module Veritas
  module Algebra
    class Union < Relation
      include Relation::Operation::Set
    end # class Union
  end # module Algebra
end # module Veritas

require 'veritas/algebra/union/body'
