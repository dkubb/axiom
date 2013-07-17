# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A class representing an absolute function
      class Absolute < Numeric
        include Unary

        # Return the absolute operation
        #
        # @example
        #   Absolute.operation  # => :abs
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :abs
        end

        module Methods
          extend Aliasable

          inheritable_alias(abs: :absolute)

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
        Numeric.class_eval            { include Methods }

      end # class Absolute
    end # class Numeric
  end # class Function
end # module Axiom
