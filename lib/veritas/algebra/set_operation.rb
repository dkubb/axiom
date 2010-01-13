module Veritas
  module Algebra
    module SetOperation
      include BinaryOperation

      def self.included(klass)
        klass.extend ClassMethods
      end

      def header
        @header ||= left.header
      end

      def body
        @body ||= Relation::Body.new(self.class::Body.new(left, right), header)
      end

      module ClassMethods
        def new(left, right)
          unless left.header == right.header
            raise InvalidHeaderError, "the headers must be equivalent for #{name}.new"
          end

          super
        end
      end

    end # module SetOperation
  end # module Algebra
end # module Veritas
