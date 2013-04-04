# encoding: utf-8

module Axiom
  class Attribute

    # A mixin for attributes that have comparable values
    module Comparable
      include Function::Predicate::GreaterThan::Methods,
              Function::Predicate::GreaterThanOrEqualTo::Methods,
              Function::Predicate::LessThan::Methods,
              Function::Predicate::LessThanOrEqualTo::Methods,
              Aggregate::Minimum::Methods,
              Aggregate::Maximum::Methods,
              Aggregate::Mean::Methods,
              Aggregate::Variance::Methods,
              Aggregate::StandardDeviation::Methods

      # Sort the attribute in ascending order
      #
      # @example
      #   ascending = attribute.asc
      #
      # @return [Relation::Operation::Order::Ascending]
      #
      # @api public
      def asc
        Relation::Operation::Order::Ascending.new(self)
      end

      # Sort the attribute in descending order
      #
      # @example
      #   descending = attribute.desc
      #
      # @return [Relation::Operation::Order::Descending]
      #
      # @api public
      def desc
        Relation::Operation::Order::Descending.new(self)
      end

    end # module Comparable
  end # class Attribute
end # module Axiom
