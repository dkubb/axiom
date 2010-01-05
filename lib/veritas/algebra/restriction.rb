module Veritas
  module Algebra
    class Restriction < Relation
      attr_reader :relation, :block

      def initialize(relation, &block)
        @relation, @block = relation, block
      end

    end # class Restriction
  end # module Algebra
end # module Veritas
