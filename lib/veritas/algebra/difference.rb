module Veritas
  module Algebra
    class Difference < Relation
      include SetOperation

      def self.operation
        :difference
      end

    end # class Difference
  end # module Algebra
end # module Veritas
