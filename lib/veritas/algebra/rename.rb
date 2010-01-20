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
        relation = self.relation.optimize

        if relation.kind_of?(self.class)
          # TODO: create Rename::Aliases object, and move this to the union method

          aliases  = relation.aliases.dup
          inverted = aliases.invert

          self.aliases.each do |old_attribute, new_attribute|
            old_attribute = inverted.fetch(old_attribute, old_attribute)

            if old_attribute == new_attribute
              aliases.delete(new_attribute)
            else
              aliases[old_attribute] = new_attribute
            end
          end

          relation = relation.relation

          if aliases.empty?
            relation
          else
            self.class.new(relation, aliases)
          end
        else
          super
        end
      end

    end # class Rename
  end # module Algebra
end # module Veritas
