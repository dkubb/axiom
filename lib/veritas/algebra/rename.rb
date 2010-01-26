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
        @header ||= relation.header.rename(@aliases)
      end

      def each(&block)
        relation.each do |tuple|
          yield Tuple.new(header, tuple.to_ary)
        end
        self
      end

      def optimize
        relation = optimize_relation

        case relation
          when Relation::Empty          then new_empty_relation
          when self.class               then optimize_rename(relation)
          when Projection               then optimize_projection(relation)
          when Relation::Operation::Set then optimize_set(relation)
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

      def optimize_rename(other)
        aliases  = optimize_aliases(other)
        relation = other.relation

        if aliases.empty?
          relation
        else
          other.class.new(relation, aliases)
        end
      end

      def optimize_projection(projection)
        # push renames beneath the projection
        projection.class.new(new(projection.relation), header)
      end

      def optimize_set(set)
        # push renames down to each relation in the set operation
        set.class.new(new(set.left), new(set.right))
      end

      # TODO: create Rename::Aliases object, and move this to a #union method
      def optimize_aliases(other)
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

    end # class Rename
  end # module Algebra
end # module Veritas
