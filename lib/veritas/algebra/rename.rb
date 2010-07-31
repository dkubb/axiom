module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      attr_reader :aliases

      def initialize(operand, aliases)
        super(operand)
        @aliases    = aliases.to_hash
        @header     = operand.header.rename(@aliases)
        @directions = operand.directions.rename(@aliases)
        @predicate  = operand.predicate.rename(@aliases)
      end

      def each(&block)
        operand.each do |tuple|
          yield Tuple.new(header, tuple.to_ary)
        end
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

      def wrap
        self.class.new(yield(optimize_operand), optimize_aliases)
      end

      def eql?(other)
        instance_of?(other.class)   &&
        aliases.eql?(other.aliases) &&
        operand.eql?(other.operand)
      end

    private

      def new(operand)
        self.class.new(operand, optimize_aliases)
      end

      def new_optimized_operation
        new(optimize_operand)
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

      # TODO: create Rename::Aliases object, and move this to a #union method
      def union_aliases
        other_aliases = optimize_operand.aliases.dup
        inverted      = other_aliases.invert

        aliases.each do |old_attribute, new_attribute|
          old_attribute = inverted.fetch(old_attribute, old_attribute)

          if old_attribute == new_attribute
            other_aliases.delete(new_attribute)
          else
            other_aliases[old_attribute] = new_attribute
          end
        end

        other_aliases
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
