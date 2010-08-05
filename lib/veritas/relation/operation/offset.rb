module Veritas
  class Relation
    module Operation
      class Offset < Relation
        include Unary

        def self.new(operand, offset)
          assert_ordered_operand(operand)
          assert_valid_offset(offset)
          super
        end

        class << self
        private

          def assert_ordered_operand(operand)
            if operand.directions.empty?
              raise OrderedRelationRequiredError, 'can only offset an ordered operand'
            end
          end

          def assert_valid_offset(offset)
            if offset < 0
              raise InvalidOffsetError, "offset must be greater than or equal to 0, but was #{offset.inspect}"
            end
          end

        end

        def initialize(operand, offset)
          super(operand)
          @offset = offset.to_int
        end

        def each
          operand.each_with_index do |tuple, index|
            yield tuple if index >= @offset
          end
          self
        end

        def optimize
          return drop_current_offset if to_i == 0

          case optimize_operand
            when Offset then use_offset_sum
            else
              super
          end
        end

        def wrap
          new(yield(optimize_operand))
        end

        def to_i
          @offset
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_i.eql?(other.to_i)     &&
          operand.eql?(other.operand)
        end

      private

        def new(operand)
          self.class.new(operand, to_i)
        end

        def drop_current_offset
          optimize_operand
        end

        def use_offset_sum
          offset = optimize_operand
          self.class.new(offset.operand, to_i + offset.to_i)
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:drop => :offset)

          def offset(offset)
            Operation::Offset.new(self, offset)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
