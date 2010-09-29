module Veritas
  module Logic
    class Predicate
      module Comparable
        include Immutable

        def self.included(descendant)
          descendant.extend ClassMethods
          self
        end

        def inspect
          "#{left.inspect} #{self.class.operation} #{right.inspect}"
        end

        module ClassMethods
          def call(left, right)
            # methods ending in ? should return true or false only,
            # force boolean context using !!
            !!left.send(operation, right)
          end

        end # module Classmethods
      end # module Comparable
    end # class Predicate
  end # module Logic
end # module Veritas
