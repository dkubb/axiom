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

        class << self
        private

          def assert_ordered_operand(operand)
            if operand.directions.empty?
              raise OrderedRelationRequiredError, 'can only limit an ordered operand'
            end
          end

          def assert_valid_limit(limit)
            if limit < 0
              raise InvalidLimitError, "limit must be greater than or equal to 0, but was #{limit.inspect}"
            end
          end

        end

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

        def optimize
          return new_empty_relation if to_i == 0

          case optimize_operand
            when Limit then optimize_limit
            else
              super
          end
        end

        def wrap
          new(yield(optimize_operand))
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

        def new(operand)
          self.class.new(operand, to_i)
        end

        def new_optimized_operation
          new(optimize_operand)
        end

        def optimize_limit
          limit = optimize_operand
          if to_i == limit.to_i
            drop_current_limit
          else
            use_smallest_limit
          end
        end

        def drop_current_limit
          optimize_operand
        end

        def use_smallest_limit
          limit = optimize_operand
          self.class.new(limit.operand, [ to_i, limit.to_i ].min)
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:take => :limit)

          def limit(limit)
            Operation::Limit.new(self, limit)
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
