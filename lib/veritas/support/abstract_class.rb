# encoding: utf-8

module Veritas
  module AbstractClass

    # Hook called when module is included
    #
    # @param [Module] descendant
    #   the module or class including AbstractClass
    #
    # @return [self]
    #
    # @api private
    def self.included(descendant)
      super
      descendant.extend ClassMethods
      self
    end

    module ClassMethods

      # Instantiate a new object
      #
      # Ensures that the instance cannot be of the abstract class
      # and must be a descendant.
      #
      # @example
      #   object = AbstractClass.new
      #
      # @return [Object]
      #
      # @api public
      def new(*)
        if superclass.equal?(Object)
          raise NotImplementedError, "#{self} is an abstract class"
        else
          super
        end
      end

    end # module ClassMethods
  end # module AbstractClass
end # module Veritas
