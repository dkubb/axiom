module Veritas
  module Logic
    module Expression
      extend Aliasable
      include Optimizable

      inheritable_alias(
        :and => :&,
        :or  => :|,
        :not => :-
      )

      def self.included(klass)
        klass.extend ClassMethods
      end

      def and(other)
        Connective::Conjunction.new(self, other)
      end

      def or(other)
        Connective::Disjunction.new(self, other)
      end

      def not(other)
        self.and(Connective::Negation.new(other))
      end

      def invert
        Connective::Negation.new(self)
      end

      def project(attributes)
        self
      end

      def rename(aliases)
        self
      end

      def ==(other)
        optimize.eql?(other.optimize)
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
  end # module Logic
end # module Veritas
