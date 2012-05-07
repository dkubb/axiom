# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A class representing an insertion into a relation
      class Insertion < Algebra::Union
        module Methods

          # Return a relation that represents an insertion into a relation
          #
          # @example
          #   insertion = relation.insert(other)
          #
          # @param [Enumerable] other
          #
          # @return [Insertion]
          #
          # @api public
          def insert(other)
            Insertion.new(self, coerce(other))
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Insertion
    end # module Operation
  end # class Relation
end # module Veritas
