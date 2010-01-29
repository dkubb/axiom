module Veritas
  module Algebra
    class Restriction
      module Expression
        include Optimizable

        def self.included(klass)
          klass.extend ClassMethods
        end

        def and(other)
          Conjunction.new(self, other)
        end

        alias & and

        def or(other)
          Disjunction.new(self, other)
        end

        alias | or

        def not(other)
          self.and(Negation.new(other))
        end

        alias - not

        def invert
          Negation.new(self)
        end

        def ==(other)
          eql?(other.optimize)
        end

        def eql?(other)
          raise NotImplementedError, "#{self.class.name}#eql? must be implemented"
        end

        def hash
          raise NotImplementedError, "#{self.class.name}#hash must be implemented"
        end

        def inspect
          raise NotImplementedError, "#{self.class.name}#inspect must be implemented"
        end

        module ClassMethods
          def eval(*)
            raise NotImplementedError, "#{name}.eval must be implemented"
          end

        end # module ClassMethods
      end # module Expression
    end # class Restriction
  end # module Algebra
end # module Veritas
