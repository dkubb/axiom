module Veritas
  module AbstractClass
    def self.included(descendant)
      descendant.extend ClassMethods
      self
    end

    module ClassMethods
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
