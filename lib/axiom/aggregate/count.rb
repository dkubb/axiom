# encoding: utf-8

module Axiom
  class Aggregate

    # The count of a series of values
    class Count < Aggregate

      DEFAULT = 0

      # Return the count for a series of values
      #
      # @example
      #   count = Count.call(count, value)
      #
      # @param [Integer] count
      #
      # @param [Object] value
      #
      # @return [Integer]
      #
      # @api public
      def self.call(count, value)
        value.nil? ? count : count.succ
      end

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Aggregate::Count.type  # => Axiom::Types::Integer
      #
      # @return [Class<Types::Integer>]
      #
      # @api public
      def self.type
        Types::Integer
      end

      module Methods

        # Return a count aggregate function
        #
        # @example
        #   count = attribute.count
        #
        # @param [Attribute]
        #
        # @return [Count]
        #
        # @api public
        def count
          Count.new(self)
        end

      end # module Methods
    end # class Count
  end # class Aggregate
end # module Axiom
