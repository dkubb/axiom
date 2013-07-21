# encoding: utf-8

module Axiom
  class Aggregate

    # The mean of a sequence of numbers
    class Mean < Aggregate

      DEFAULT = [0, nil].freeze

      # Return the count and mean for a sequence of numbers
      #
      # @example
      #   count, mean = Mean.call([count, mean], value)
      #
      # @param [Array(Integer, Numeric)] accumulator
      #
      # @param [Numeric] value
      #
      # @return [Array(Integer, Numeric)]
      #
      # @api public
      def self.call(accumulator, value)
        return accumulator if value.nil?
        count, mean = accumulator
        count       = Count.call(count, value)
        [count, mean ? Rational(value - mean, count) + mean : Rational(value)]
      end

      # Extract the mean from the accumulator
      #
      # @example
      #   mean = Mean.finalize(accumulator)
      #
      # @param [Array(Integer, Numeric)] accumulator
      #
      # @return [Float]
      #   returned for a non-empty set
      # @return [nil]
      #   returned for an empty set
      #
      # @api public
      def self.finalize(accumulator)
        accumulator.last
      end

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Aggregate::Mean.type
      #
      # @return [Class<Attribute::Float>]
      #
      # @api public
      def type
        Attribute::Float
      end

      module Methods
        extend Aliasable

        inheritable_alias(
          average: :mean,
          avg:     :mean
        )

        # Return a mean aggregate function
        #
        # @example
        #   mean = attribute.mean
        #
        # @param [Attribute]
        #
        # @return [Mean]
        #
        # @api public
        def mean
          Mean.new(self)
        end

      end # module Methods
    end # class Mean
  end # class Aggregate
end # module Axiom
