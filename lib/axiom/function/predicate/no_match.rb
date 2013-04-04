# encoding: utf-8

module Axiom
  class Function
    class Predicate

      # A predicate representing no regexp match between operands
      class NoMatch < Predicate
        include Comparable

        # Return the NoMatch operation
        #
        # @example
        #   NoMatch.operation  # => :!~
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :'!~'
        end

        # Return the inverse predicate class
        #
        # @example
        #   NoMatch.inverse  # => Match
        #
        # @return [Class<Match>]
        #
        # @api public
        def self.inverse
          Match
        end

        # Evaluate the values for no match
        #
        # @example
        #   NoMatch.call(left, right)  # => true or false
        #
        # @param [Object] left
        # @param [Object] right
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          left !~ right
        end

        module Methods

          # Compare the left to see if does not match the right
          #
          # @example
          #   no_match = expression.no_match(regexp)
          #
          # @param [Regexp] regexp
          #
          # @return [NoMatch]
          #
          # @api public
          def no_match(regexp)
            NoMatch.new(self, regexp)
          end

        end # module Methods
      end # class NoMatch
    end # class Predicate
  end # class Function
end # module Axiom
