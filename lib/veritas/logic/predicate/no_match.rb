module Veritas
  module Logic
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
        end unless Object.method_defined?(operation)

        module Methods

          # Compare the left to see if does not match the right
          #
          # @example
          #   no_match = expression.no_match(regexp)
          #
          # @param [Expression] other
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
  end # module Logic
end # module Veritas
