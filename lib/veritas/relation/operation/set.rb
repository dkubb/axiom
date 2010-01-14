module Veritas
  class Relation
    module Operation
      module Set
        include Binary

        def self.included(klass)
          klass.extend ClassMethods
        end

        def body
          @body ||= self.class::Body.new(left.body, right.body)
        end

        module ClassMethods
          def new(left, right)
            unless left.header == right.header
              raise InvalidHeaderError, "the headers must be equivalent for #{name}.new"
            end

            super
          end
        end # module ClassMethods
      end # module Set
    end # module Operation
  end # class Relation
end # module Veritas
