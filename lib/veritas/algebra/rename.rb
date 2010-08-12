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

      def optimize
        case optimize_operand
          when Relation::Empty               then new_empty_relation
          when self.class                    then optimize_rename
          when Projection                    then wrap_with_projection
          when Restriction                   then wrap_with_restriction
          when Relation::Operation::Set,
               Relation::Operation::Reverse,
               Relation::Operation::Limit,
               Relation::Operation::Offset   then wrap_with_operation
          when Relation::Operation::Order    then wrap_with_order
          else
            super
        end
      end

      def optimized?
        super && optimize_aliases.equal?(aliases)
      end

      def wrap
        new(yield(optimize_operand))
      end

      def eql?(other)
        super && aliases.eql?(other.aliases)
      end

    private

      def new(operand)
        self.class.new(operand, optimize_aliases)
      end

      def optimize_rename
        optimize_aliases.empty? ? drop_no_op_renames : combine_renames
      end

      def drop_no_op_renames
        optimize_operand.operand
      end

      def combine_renames
        new(optimize_operand.operand)
      end

      def wrap_with_operation
        optimize_operand.wrap { |relation| new(relation) }.optimize
      end

      def wrap_with_projection
        optimize_operand.wrap(header) { |relation| new(relation) }.optimize
      end

      def wrap_with_restriction
        optimize_operand.wrap(predicate) { |relation| new(relation) }.optimize
      end

      def wrap_with_order
        optimize_operand.wrap(directions) { |relation| new(relation) }.optimize
      end

      def optimize_aliases
        optimize_operand.respond_to?(:aliases) ? union_aliases : aliases
      end

      def union_aliases
        aliases.union(optimize_operand.aliases)
      end

      def predicate
        optimize_operand.predicate.rename(@aliases)
      end

      memoize :optimize

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
