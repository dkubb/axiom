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

        def self.assert_ordered_operand(operand)
          if operand.directions.empty?
            raise OrderedRelationRequiredError, 'can only offset an ordered operand'
          end
        end

        def self.assert_valid_offset(offset)
          if offset < 0
            raise InvalidOffsetError, "offset must be greater than or equal to 0, but was #{offset.inspect}"
          end
        end

        private_class_method :assert_ordered_operand, :assert_valid_offset

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

        def to_i
          @offset
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_i.eql?(other.to_i)     &&
          operand.eql?(other.operand)
        end

      private

        module Methods
          def drop(offset)
            Offset.new(self, offset)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
