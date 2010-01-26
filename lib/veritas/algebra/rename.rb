module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      attr_reader :aliases

      def initialize(relation, aliases)
        @aliases = aliases
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

      def optimize
        case optimize_relation
          when Relation::Empty              then new_empty_relation
          when self.class                   then optimize_rename
          when Projection                   then move_before_projection
          when Relation::Operation::Set     then move_before_set
          when Relation::Operation::Reverse then move_before_reverse
          when Relation::Operation::Order   then move_before_order
          else
            super
        end
      end

    private

      def new(relation)
        self.class.new(relation, aliases)
      end

      def new_optimized_operation
        self.class.new(optimize_relation, aliases)
      end

      def optimize_rename
        optimize_aliases.empty? ? drop_no_op_renames : combine_renames
      end

      def drop_no_op_renames
        optimize_relation.relation
      end

      def combine_renames
        self.class.new(optimize_relation.relation, optimize_aliases)
      end

      def move_before_projection
        projection = optimize_relation
        projection.class.new(new(projection.relation), header)
      end

      def move_before_set
        set = optimize_relation
        set.class.new(new(set.left), new(set.right))
      end

      def move_before_reverse
        reverse = optimize_relation
        reverse.class.new(new(reverse.relation))
      end

      def move_before_order
        order = optimize_relation
        order.class.new(new(order.relation), directions)
      end

      # TODO: create Rename::Aliases object, and move this to a #union method
      def optimize_aliases
        @optimize_aliases ||=
          begin
            other    = optimize_relation
            aliases  = other.aliases.dup
            inverted = aliases.invert

            self.aliases.each do |old_attribute, new_attribute|
              old_attribute = inverted.fetch(old_attribute, old_attribute)

              if old_attribute == new_attribute
                aliases.delete(new_attribute)
              else
                aliases[old_attribute] = new_attribute
              end
            end

            aliases
          end
      end

    end # class Rename
  end # module Algebra
end # module Veritas
