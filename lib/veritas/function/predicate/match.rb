module Veritas
  module Function
    class Predicate

      # A predicate representing a regexp match between operands
      class Match < Predicate
        include Comparable

        # Return the Match operation
        #
        # @example
        #   Match.operation  # => :=~
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :=~
        end

        # Return the inverse predicate class
        #
        # @example
        #   Match.inverse  # => NoMatch
        #
        # @return [Class<NoMatch>]
        #
        # @api public
        def self.inverse
          NoMatch
        end

        module Methods

          # Compare the left to see if it matches the right
          #
          # @example
          #   match = expression.match(regexp)
          #
          # @param [Expression] other
          #
          # @return [Match]
          #
          # @api public
          def match(regexp)
            Match.new(self, regexp)
          end

        end # module Methods
      end # class Match
    end # class Predicate
  end # module Function
end # module Veritas
