module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      attr_reader :aliases

      def initialize(operand, aliases)
        super(operand)
        @aliases    = Aliases.coerce(@header, aliases)
        @header     = @header.rename(@aliases)
        @directions = @directions.rename(@aliases)
      end

      def each(&block)
        operand.each { |tuple| yield Tuple.new(header, tuple.to_ary) }
        self
      end

      def eql?(other)
        super && aliases.eql?(other.aliases)
      end

      module Methods
        def rename(aliases)
          Rename.new(self, aliases)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Rename
  end # module Algebra
end # module Veritas

require 'veritas/algebra/rename/aliases'
