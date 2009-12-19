module Veritas
  module Algebra
    module SetOperation
      attr_reader :left, :right

      def self.included(klass)
        klass.extend ClassMethods
      end

      def initialize(left, right)
        @left, @right = left, right
      end

      def header
        @header ||= @left.header
      end

      module ClassMethods
        def new(left, right)
          unless left.header == right.header
            raise HeaderMismatchError, "the headers must be equivalent for #{self}.new"
          end

          super
        end
      end
    end # module SetOperation
  end # module Algebra
end # module Veritas
