module Veritas
  class Relation
    module Operation
      module Set
        include Binary

        def self.included(descendant)
          descendant.extend ClassMethods
          self
        end

        def initialize(left, right)
          super
          @header = left.header
        end

        module ClassMethods
          def new(left, right)
            assert_equivalent_headers(left, right)
            super
          end

        private

          def assert_equivalent_headers(left, right)
            if left.header != right.header
              raise InvalidHeaderError, "the headers must be equivalent for #{name}.new"
            end
          end

        end # module ClassMethods
      end # module Set
    end # module Operation
  end # class Relation
end # module Veritas
