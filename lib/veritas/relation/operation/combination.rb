# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A mixin for relations that combine their operands
      module Combination
        include Binary

        # Combine tuples together and yield the joined tuple
        #
        # @param [Header] header
        #   the header to use for the resulting tuples
        # @param [Tuple] left_tuple
        #   the left tuple to join with
        # @param [Enumerable<Tuple>] right_tuples
        #   the tuples to join to the left tuple
        #
        # @yield [tuple]
        #
        # @yieldparam [Tuple] tuple
        #   each joined tuple
        #
        # @return [undefined]
        #
        # @api private
        def self.combine_tuples(header, left_tuple, right_tuples)
          right_tuples.each do |right_tuple|
            yield left_tuple.join(header, right_tuple)
          end
        end

      end # module Combination
    end # module Operation
  end # class Relation
end # module Veritas
