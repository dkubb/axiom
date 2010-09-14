module Veritas
  module Algebra
    class Extension < Relation
      include Relation::Operation::Unary

      attr_reader :extensions

      def self.new(operand, extensions)
        assert_unique_header(operand, extensions)
        super
      end

      def self.assert_unique_header(operand, extensions)
        header     = operand.header
        duplicates = extensions.keys.select { |name| header[name] }.sort
        if duplicates.any?
          raise DuplicateHeaderName, "extensions with duplicate header names: #{duplicates.join(', ')}"
        end
      end

      private_class_method :assert_unique_header

      def initialize(operand, extensions)
        super(operand)
        @extensions  = Immutable.freeze_value(extensions)
        @header     |= @extensions.keys.map { |attribute| Attribute.coerce(attribute) }
      end

      def each
        header     = self.header
        extensions = self.extensions.values
        operand.each { |tuple| yield tuple.extend(header, extensions) }
        self
      end

      module Methods
        def extend(&block)
          evaluator = Evaluator::Expression.new(&block)
          Extension.new(self, evaluator.expressions)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Extension
  end # module Algebra
end # module Veritas
