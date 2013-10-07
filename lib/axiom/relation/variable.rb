# encoding: utf-8

module Axiom
  class Relation

    # A relation variable
    class Variable < Relation
      include Adamantium::Mutable, Proxy

      # Instantiate a new relation variable
      #
      # @example
      #   relvar = Relation::Variable.new(relation)
      #
      # @param [Relation] relation
      #
      # @return [Relation::Variable]
      #
      # @api public
      def self.new(relation)
        if equal?(Variable) && relation.materialized?
          Materialized.new(relation)
        else
          super
        end
      end

      # Initialize a relation variable
      #
      # @param [Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(relation)
        @relation = relation
        @mutex    = Mutex.new
      end

      # Insert tuples into the relation variable
      #
      # @example
      #   relvar.insert(other)
      #
      # @param [Enumerable] other
      #
      # @return [self]
      #
      # @api public
      def insert(other)
        @mutex.synchronize { mutate_relation(__method__, other) }
        self
      end

      # Delete tuples from the relation variable
      #
      # @example
      #   relvar.delete(other)
      #
      # @param [Enumerable] other
      #
      # @return [self]
      #
      # @api public
      def delete(other)
        @mutex.synchronize { mutate_relation(__method__, other) }
        self
      end

      # Replace the relation variable with new tuples
      #
      # @example
      #   relvar.replace(other)
      #
      # @param [Enumerable] other
      #
      # @return [self]
      #
      # @api public
      def replace(other)
        @mutex.synchronize { mutate_relation(__method__, other) }
        self
      end

    private

      # Mutate the relation variable
      #
      # @param [Symbol] method
      # @param [Enumerable] other
      #
      # @return [undefined]
      #
      # @api private
      def mutate_relation(*args)
        @relation = relation.public_send(*args)
      end

      # A materialized relation variable
      class Materialized < self

        # Mutate and materialize the relation variable
        #
        # @return [undefined]
        #
        # @api private
        def mutate_relation(*)
          super
          @relation = relation.materialize
        end
        private :mutate_relation

      end # class Materialized
    end # class Variable
  end # class Relation
end # module Axiom
