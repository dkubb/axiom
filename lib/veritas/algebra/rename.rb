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
          when Relation::Operation::Limit   then move_before_limit
          when Relation::Operation::Offset  then move_before_offset
          else
            super
        end
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

      def move_before_projection
        projection = optimize_relation
        projection.class.new(new(projection.relation), header).optimize
      end

      def move_before_set
        set = optimize_relation
        set.class.new(new(set.left), new(set.right)).optimize
      end

      def move_before_reverse
        reverse = optimize_relation
        reverse.class.new(new(reverse.relation)).optimize
      end

      def move_before_order
        order = optimize_relation
        order.class.new(new(order.relation), directions).optimize
      end

      def move_before_limit
        limit = optimize_relation
        limit.class.new(new(limit.relation), limit.to_i).optimize
      end

      def move_before_offset
        offset = optimize_relation
        offset.class.new(new(offset.relation), offset.to_i).optimize
      end

      # TODO: create Rename::Aliases object, and move this to a #union method
      def optimize_aliases
        @optimize_aliases ||=
          begin
            other = optimize_relation
            if other.respond_to?(:aliases)
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
            else
              self.aliases
            end
          end
      end

    end # class Rename
  end # module Algebra
end # module Veritas
