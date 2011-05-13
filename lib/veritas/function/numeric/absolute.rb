# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing an absolute function
      class Absolute < Numeric
        include Unary

        # Return the absolute value
        #
        # @example
        #   absolute_value = Absolute.call(value)
        #
        # @param [Numeric] value
        #
        # @return [Numeric]
        #
        # @api public
        def self.call(value)
          value.abs
        end

        # Return a string representing the absolute function
        #
        # @example
        #   absolute.inspect  # => "ABS(-1)"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "ABS(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:abs => :absolute)

          # Return an absolute function
          #
          # @example
          #   absolute = attribute.absolute
          #
          # @return [Absolute]
          #
          # @api public
          def absolute
            Absolute.new(self)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }

      end # class Absolute
    end # class Numeric
  end # class Function
end # module Veritas
