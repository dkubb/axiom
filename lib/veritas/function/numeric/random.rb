# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing a random function
      class Random < Numeric
        include Unary

        # Return a random value less than the value
        #
        # @example
        #   random_value = Random.call(value)
        #
        # @param [Numeric] value
        #
        # @return [Numeric]
        #
        # @api public
        def self.call(value)
          rand(value)
        end

        # Return a string representing the random function
        #
        # @example
        #   random.inspect  # => "RAND(-1)"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "RAND(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:rand => :random)

          # Return a random function
          #
          # @example
          #   random = attribute.random
          #
          # @return [Random]
          #
          # @api public
          def random
            Random.new(self)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }

      end # class Random
    end # class Numeric
  end # class Function
end # module Veritas
