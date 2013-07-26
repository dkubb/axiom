# encoding: utf-8

module Axiom
  class Relation

    # A variable relation
    class Variable < Relation
      include Adamantium::Mutable, Proxy

      # Initialize a variable relation
      #
      # @param [Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(relation)
        @relation     = relation
        @materialized = @relation.materialized?
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
      end

    private

      # Apply the mutation operation to the relation
      #
      # @param [Symbol] method
      # @param [Enumerable] other
      #
      # @return [self]
      #
      # @api private
      def mutate_relation(*args)
        @relation = relation.public_send(*args)
        @relation = @relation.materialize if @materialized
        self
      end

    end # class Variable
  end # class Relation
end # module Axiom
