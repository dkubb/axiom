# encoding: utf-8

module Veritas
  class Function

    # A mixin for functions with directly compared operands
    module Comparable

      # Hook called when module is included
      #
      # @param [Module] descendant
      #   the module or class including Comparable
      #
      # @return [undefined]
      #
      # @api private
      def self.included(descendant)
        super
        descendant.extend ClassMethods
      end

      private_class_method :included

      module ClassMethods

        # Evaluate the values using the ruby operation
        #
        # @example
        #   function.call(left, right)  # => true or false
        #
        # @param [Object] left
        # @param [Object] right
        #
        # @return [Object]
        #
        # @api public
        def call(left, right)
          left.send(operation, right)
        end

      end # module Classmethods
    end # class Predicate
  end # class Function
end # module Veritas
