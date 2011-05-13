# encoding: utf-8

module Veritas
  class Attribute

    # A mixin for attributes that have comparable values
    module Comparable
      include Orderable,
              Function::Predicate::GreaterThan::Methods,
              Function::Predicate::GreaterThanOrEqualTo::Methods,
              Function::Predicate::LessThan::Methods,
              Function::Predicate::LessThanOrEqualTo::Methods,
              Aggregate::Minimum::Methods,
              Aggregate::Maximum::Methods,
              Aggregate::Mean::Methods,
              Aggregate::Variance::Methods,
              Aggregate::StandardDeviation::Methods

      # Compare the attribute with other attribute to see if they are of the same type
      #
      # @example
      #   attribute.comparable?(other)  # => true or false
      #
      # @param [Attribute] other
      #   the other attribute to compare with
      #
      # @return [Boolean]
      #
      # @todo figure out how to dry this up with Attribute#joinable?
      #
      # @api public
      def comparable?(other)
        kind_of?(other.class) || other.kind_of?(self.class)
      end

    end # module Comparable
  end # class Attribute
end # module Veritas
