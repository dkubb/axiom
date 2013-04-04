# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing an insertion into a relation
      class Insertion < Relation
        include Proxy

        # Initialize an Insertion
        #
        # @param [Array(Relation, Relation)] args
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*args)
          @relation = Algebra::Union.new(*args)
        end

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
end # module Axiom
