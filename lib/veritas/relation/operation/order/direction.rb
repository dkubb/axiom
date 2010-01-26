module Veritas
  class Relation
    module Operation
      class Order
        class Direction
          include AbstractClass

          attr_reader :attribute

          def initialize(attribute)
            @attribute = attribute
          end

          def call(left, right)
            attribute = self.attribute
            self.class.eval(left[attribute], right[attribute])
          end

          def rename(name)
            self.class.new(attribute.rename(name))
          end

          def eql?(other)
            instance_of?(other.class) &&
            attribute.eql?(other.attribute)
          end

          alias == eql?

          def hash
            @hash ||= attribute.hash
          end

          def self.coerce(object)
            object.kind_of?(Direction) ? object : new(object)
          end

        end # class Direction

        class Ascending < Direction
          def reverse
            Descending.new(attribute)
          end

          def self.eval(left, right)
            left <=> right
          end
        end # class Ascending

        class Descending < Direction
          def reverse
            Ascending.new(attribute)
          end

          def self.eval(left, right)
            right <=> left
          end
        end # class Descending
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
