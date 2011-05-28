# encoding: utf-8

module Veritas
  class Function
    class Numeric

      # A class representing an addition function
      class Addition < Numeric
        include Binary, Comparable

        # Return the Addition operation
        #
        # @example
        #   Addition.operation  # => :+
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :+
        end

        # Return the inverse function class
        #
        # @example
        #   Addition.inverse  # => Subtraction
        #
        # @return [Class<Subtraction>]
        #
        # @api public
        def self.inverse
          Subtraction
        end

        module Methods
          extend Aliasable

          inheritable_alias(:+ => :add)

          # Return an addition function
          #
          # @example
          #   addition = attribute.add(other)
          #
          # @param [Object] other
          #
          # @return [Addition]
          #
          # @api public
          def add(other)
            Addition.new(self, other)
          end

        end # module Methods

        Attribute::Numeric.class_eval { include Methods }
        Numeric.class_eval            { include Methods }

      end # class Addition
    end # class Numeric
  end # class Function
end # module Veritas
