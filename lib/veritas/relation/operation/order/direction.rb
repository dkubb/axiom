module Veritas
  class Relation
    module Operation
      class Order
        class Direction
          include AbstractClass, Immutable

          attr_reader :attribute

          def initialize(attribute)
            @attribute = attribute
          end

          def call(left, right)
            attribute = self.attribute
            self.class.eval(left[attribute], right[attribute])
          end

          def rename(aliases)
            attribute = self.attribute
            renamed   = attribute.rename(aliases)
            renamed.equal?(attribute) ? self : self.class.new(renamed)
          end

          def reverse
            self.class.reverse.new(attribute)
          end

          def eql?(other)
            instance_of?(other.class) &&
            attribute.eql?(other.attribute)
          end

          def ==(other)
            eql?(other)
          end

          def hash
            attribute.hash
          end

          def self.coerce(object)
            object.kind_of?(Direction) ? object : new(object)
          end

        end # class Direction

        class Ascending < Direction
          def self.reverse
            Descending
          end

          def self.eval(left, right)
            left <=> right
          end

        end # class Ascending

        class Descending < Direction
          def self.reverse
            Ascending
          end

          def self.eval(left, right)
            right <=> left
          end

        end # class Descending
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
