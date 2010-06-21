module Veritas
  class Relation
    module Operation
      class Limit < Relation
        include Unary

        def self.new(relation, limit)
          assert_ordered_relation(relation)
          assert_valid_limit(limit)
          super
        end

        class << self
        private

          def assert_ordered_relation(relation)
            if relation.directions.empty?
              raise OrderedRelationRequiredError, 'can only limit an ordered relation'
            end
          end

          def assert_valid_limit(limit)
            if limit < 0
              raise InvalidLimitError, "limit must be greater than or equal to 0, but was #{limit.inspect}"
            end
          end

        end

        def initialize(relation, limit)
          @limit = limit.to_int
          super(relation)
        end

        def each
          relation.each_with_index do |tuple, index|
            break if @limit == index
            yield tuple
          end
          self
        end

        def optimize
          return new_empty_relation if to_i == 0

          case optimize_relation
            when Limit then optimize_limit
            else
              super
          end
        end

        def wrap
          self.class.new(yield(relation), to_i)
        end

        def to_i
          @limit
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_i.eql?(other.to_i)     &&
          relation.eql?(other.relation)
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation, to_i)
        end

        def optimize_limit
          limit = optimize_relation
          if to_i == limit.to_i
            drop_current_limit
          else
            use_smallest_limit
          end
        end

        def drop_current_limit
          optimize_relation
        end

        def use_smallest_limit
          limit = optimize_relation
          self.class.new(limit.relation, [ to_i, limit.to_i ].min)
        end

        memoize :new_optimized_operation, :use_smallest_limit

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
