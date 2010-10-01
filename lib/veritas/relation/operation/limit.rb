module Veritas
  class Relation
    module Operation
      class Limit < Relation
        include Unary

        def self.new(operand, limit)
          assert_ordered_operand(operand)
          assert_valid_limit(limit)
          super
        end

        def self.assert_ordered_operand(operand)
          if operand.directions.empty?
            raise OrderedRelationRequiredError, 'can only limit an ordered operand'
          end
        end

        def self.assert_valid_limit(limit)
          if limit < 0
            raise InvalidLimitError, "limit must be greater than or equal to 0, but was #{limit.inspect}"
          end
        end

        private_class_method :assert_ordered_operand, :assert_valid_limit

        def initialize(operand, limit)
          super(operand)
          @limit = limit.to_int
        end

        def each
          operand.each_with_index do |tuple, index|
            break if @limit == index
            yield tuple
          end
          self
        end

        def to_i
          @limit
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_i.eql?(other.to_i)     &&
          operand.eql?(other.operand)
        end

      private

        module Methods
          extend Aliasable

          inheritable_alias(:take => :limit)

          def limit(limit)
            Limit.new(self, limit)
          end

          def first(limit = 1)
            limit(limit)
          end

          def last(limit = 1)
            reverse.first(limit).reverse
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
