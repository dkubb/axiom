# encoding: utf-8

module Axiom
  class Relation

    # A variable relation
    class Variable < Relation
      include Adamantium::Mutable, Proxy

      # Instantiate a new variable relation
      #
      # @example
      #   relval = Relation::Variable.new(relation)
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

      # Initialize a variable relation
      #
      # @param [Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(relation)
        @relation = relation
      end

      # Insert tuples into the variable relation
      #
      # @example
      #   relation.insert(other)
      #
      # @param [Enumerable] _other
      #
      # @return [self]
      #
      # @api public
      def insert(other)
        mutate_relation(__method__, other)
        self
      end

      # Delete tuples from the variable relation
      #
      # @example
      #   relation.delete(other)
      #
      # @param [Enumerable] _other
      #
      # @return [self]
      #
      # @api public
      def delete(other)
        mutate_relation(__method__, other)
        self
      end

    private

      # Apply the mutation operation to the relation
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

      # A materialized variable relation
      class Materialized < self

      private

        # Apply the mutation operation to the relation and materialize it
        #
        # @return [undefined]
        #
        # @api private
        def mutate_relation(*)
          super
          @relation = relation.materialize
        end

      end # class Materialized
    end # class Variable
  end # class Relation
end # module Axiom
