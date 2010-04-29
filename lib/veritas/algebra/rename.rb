module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      attr_reader :aliases

      def initialize(relation, aliases)
        @aliases = aliases.to_hash
        super(relation)
      end

      def header
        @header ||= relation.header.rename(aliases)
      end

      def each(&block)
        relation.each do |tuple|
          yield Tuple.new(header, tuple.to_ary)
        end
        self
      end

      def directions
        @directions ||= relation.directions.rename(aliases)
      end

      def predicate
        @predicate ||= relation.predicate.rename(aliases)
      end

      def optimize
        case optimize_relation
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
        self.class.new(yield(relation), aliases)
      end

      def eql?(other)
        instance_of?(other.class)   &&
        aliases.eql?(other.aliases) &&
        relation.eql?(other.relation)
      end

    private

      def new(relation)
        self.class.new(relation, optimize_aliases)
      end

      def new_optimized_operation
        new(optimize_relation)
      end

      def optimize_rename
        optimize_aliases.empty? ? drop_no_op_renames : combine_renames
      end

      def drop_no_op_renames
        optimize_relation.relation
      end

      def combine_renames
        new(optimize_relation.relation)
      end

      def wrap_with_operation
        optimize_relation.wrap { |relation| new(relation) }.optimize
      end

      def wrap_with_projection
        optimize_relation.wrap(header) { |relation| new(relation) }.optimize
      end

      def wrap_with_restriction
        optimize_relation.wrap(predicate) { |relation| new(relation) }.optimize
      end

      def wrap_with_order
        optimize_relation.wrap(directions) { |relation| new(relation) }.optimize
      end

      def optimize_aliases
        @optimize_aliases ||= optimize_relation.respond_to?(:aliases) ? union_aliases : aliases
      end

      # TODO: create Rename::Aliases object, and move this to a #union method
      def union_aliases
        other_aliases = optimize_relation.aliases.dup
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

    end # class Rename
  end # module Algebra
end # module Veritas
