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
        @header    |= extensions.keys.map { |name| Attribute::Object.new(name) }
        @extensions  = Immutable.freeze_value(extensions.values)
      end

      def each
        header = self.header
        operand.each do |tuple|
          values = extensions.map { |extension| extension.call(tuple) }
          yield tuple.class.new(header, tuple.to_ary + values)
        end
        self
      end

      module Methods
        def extend(extenders = yield(self))
          Extension.new(self, extenders)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Extension
  end # module Algebra
end # module Veritas
