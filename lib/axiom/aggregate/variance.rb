# encoding: utf-8

module Axiom
  class Aggregate

    # The variance of a sequence of numbers
    class Variance < Aggregate

      DEFAULT = [ 0, nil, Rational(0) ].freeze

      # Return the count, mean, and sum of squares for a sequence of numbers
      #
      # @example
      #   count, mean, sum_of_squares = Variance.call(accumulator, value)
      #
      # @param [Array(Integer, Numeric, Rational)] accumulator
      #
      # @param [Numeric] value
      #
      # @return [Array(Integer, Numeric, Rational)]
      #
      # @api public
      def self.call(accumulator, value)
        return accumulator if value.nil?
        mean, sum_of_squares  = accumulator.last(2)
        delta                 = mean.nil? ? value : value - mean
        count, new_mean       = Mean.call(accumulator, value)
        sum_of_squares       += delta * (value - new_mean)
        [ count, new_mean, sum_of_squares ]
      end

      # Calculate the variance from the accumulator
      #
      # @example
      #   variance = Variance.finalize(accumulator)
      #
      # @param [Array(Numeric, Integer, Rational)] accumulator
      #
      # @return [Rational]
      #   returned for a non-empty set
      # @return [Float::INFINITY]
      #   returned for when the sum of squares is infinite
      # @return [nil]
      #   returned for an empty set
      #
      # @api public
      def self.finalize(accumulator)
        sum_of_squares, count = accumulator.values_at(2, 0)
        return Float::INFINITY if sum_of_squares.equal?(Float::INFINITY)
        Rational(sum_of_squares, count) unless count.zero?
      end

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Aggregate::Variance.type
      #
      # @return [Class<Attribute::Float>]
      #
      # @api public
      def type
        Attribute::Float
      end

      module Methods
        extend Aliasable

        inheritable_alias(:var => :variance)

        # Return a variance aggregate function
        #
        # @example
        #   variance = attribute.variance
        #
        # @param [Attribute]
        #
        # @return [Variance]
        #
        # @api public
        def variance
          Variance.new(self)
        end

      end # module Methods
    end # class Variance
  end # class Aggregate
end # module Axiom
