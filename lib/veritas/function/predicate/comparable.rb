module Veritas
  class Function
    class Predicate

      # A mixin for predicates with directly compared operands
      module Comparable
        include Immutable

        # Hook called when module is included
        #
        # @param [Module] descendant
        #   the module or class including Comparable
        #
        # @return [self]
        #
        # @api private
        def self.included(descendant)
          descendant.extend ClassMethods
          self
        end

        # Return a string representing the predicate
        #
        # @example
        #   predicate.inspect  # (String representation of Predicate)
        #
        # @return [String]
        #
        # @api public
        def inspect
          "#{left.inspect} #{self.class.operation} #{right.inspect}"
        end

        module ClassMethods

          # Evaluate the values using the ruby operation
          #
          # @example
          #   predicate.call(left, right)  # => true or false
          #
          # @param [Object] left
          # @param [Object] right
          #
          # @return [Boolean]
          #
          # @api public
          def call(left, right)
            # methods ending in ? should return true or false only,
            # force boolean context using !!
            !!left.send(operation, right)
          end

        end # module Classmethods
      end # module Comparable
    end # class Predicate
  end # class Function
end # module Veritas
