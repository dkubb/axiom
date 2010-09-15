module Veritas
  module Logic
    class Expression
      extend Aliasable
      include AbstractClass, Optimizable, Immutable

      # alias #! to #inverse when available
      inheritable_alias('!' => :inverse) if Object.method_defined?('!')

      def self.call(*)
        raise NotImplementedError, "#{name}.call must be implemented"
      end

      def project(attributes)
        self
      end

      def rename(aliases)
        self
      end

      def inverse
        raise NotImplementedError, "#{self.class}#inverse must be implemented"
      end

      def ==(other)
        optimize.eql?(other.optimize)
      end

      def eql?(other)
        raise NotImplementedError, "#{self.class}#eql? must be implemented"
      end

      def hash
        raise NotImplementedError, "#{self.class}#hash must be implemented"
      end

      def inspect
        raise NotImplementedError, "#{self.class}#inspect must be implemented"
      end

    end # class Expression
  end # module Logic
end # module Veritas
