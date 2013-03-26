# encoding: utf-8

module Axiom
  class Function
    class Predicate

      # A predicate representing a regexp match between operands
      class Match < Predicate
        include Comparable

        # Evaluate the left and right value to see if they match
        #
        # @example
        #   matches = Match.call(left, right)
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(*)
          super ? true : false
        end

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
          # @param [Regexp] regexp
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
  end # class Function
end # module Axiom
