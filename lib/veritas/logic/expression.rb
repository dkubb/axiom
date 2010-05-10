module Veritas
  module Logic
    class Expression
      extend Aliasable
      include AbstractClass, Optimizable

      inheritable_alias(
        :& => :and,
        :| => :or,
        :- => :not
      )

      # alias #! to #complement in Ruby 1.9
      inheritable_alias('!' => :complement) if respond_to?('!')

      def self.eval(*)
        raise NotImplementedError, "#{name}.eval must be implemented"
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

      def complement
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

    end # class Expression
  end # module Logic
end # module Veritas
