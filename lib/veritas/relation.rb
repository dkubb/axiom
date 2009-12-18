module Veritas
  class Relation
    def initialize(header, body)
    end

    def union(other)
      Algebra::Union.new(self, other)
    end
  end # class Relation
end # module Veritas
