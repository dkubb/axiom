module Veritas
  module Algebra
    class Difference < Relation
      include Relation::Operation::Set
    end # class Difference
  end # module Algebra
end # module Veritas

require 'veritas/algebra/difference/body'
