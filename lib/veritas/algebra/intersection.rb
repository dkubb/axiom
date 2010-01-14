module Veritas
  module Algebra
    class Intersection < Relation
      include Relation::Operation::Set
    end # class Intersection
  end # module Algebra
end # module Veritas

require 'veritas/algebra/intersection/body'
