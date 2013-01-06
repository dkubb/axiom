# encoding: utf-8

module Veritas
  module Algebra

    # Extend a relation to include calculated attributes
    class Extension < Relation
      include Relation::Operation::Unary
      include Equalizer.new(:operand, :extensions)

      # The extensions for the relation
      #
      # @return [Hash]
      #
      # @api private
      attr_reader :extensions

      # Initialize an Extension
      #
      # @param [Relation] operand
      #   the relation to extend
      # @param [#to_hash] extensions
      #   the extensions to add
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, extensions)
        super(operand)
        extensions  = extensions.to_hash
        keys        = extensions.keys
        @header     = @header.extend(keys)
        @extensions = Hash[@header.project(keys).zip(extensions.values)]
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   extension = Extension.new(operand, extensions)
      #   extension.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        extensions = self.extensions.values
        operand.each { |operand_tuple| yield operand_tuple.extend(header, extensions) }
        self
      end

      # Insert a relation into the Extension
      #
      # The other relation must be a matching extension.
      #
      # @example
      #   new_relation = extension.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Extension]
      #
      # @raise [ExtensionMismatchError]
      #   raised when inserting with a mismatching extension
      #
      # @api public
      def insert(other)
        assert_matching_extensions(other, INSERTED)
        operand.insert(other.operand).extend(extensions)
      end

      # Delete a relation from the Extension
      #
      # The other relation must be a matching extension.
      #
      # @example
      #   new_relation = extension.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Extension]
      #
      # @raise [ExtensionMismatchError]
      #   raised when deleting with a mismatching extension
      #
      # @api public
      def delete(other)
        assert_matching_extensions(other, DELETED)
        operand.delete(other.operand).extend(extensions)
      end

    private

      # Assert that the other relation has matching extensions
      #
      # @param [Relation] other
      #
      # @param [String] event
      #
      # @return [undefined]
      #
      # @raise [ExtensionMismatchError]
      #   raised when inserting a relation does not have matching extensions
      #
      # @api private
      def assert_matching_extensions(other, event)
        unless other.kind_of?(self.class) && extensions.eql?(other.extensions)
          raise ExtensionMismatchError, "other relation must have matching extensions to be #{event}"
        end
      end

      module Methods

        # Return an extended relation
        #
        # @example with extensions
        #  extension = relation.extend(extensions)
        #
        # @example with a context block
        #   extension = relation.extend do |context|
        #     context.add(:total, context[:unit_price] * context[:quantity])
        #   end
        #
        # @param [Array] args
        #   optional arguments
        #
        # @yield [function]
        #   Evaluate an extension function
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the function within
        #
        # @return [Extension]
        #
        # @api public
        def extend(*args, &block)
          Extension.new(self, coerce_to_extensions(*args, &block))
        end

      private

        # Coerce the arguments and block into a extensions
        #
        # @param [#to_hash] extensions
        #   optional extensions with attribute keys and function/literal values
        #
        # @yield [function]
        #   Evaluate an extension function
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the function within
        #
        # @return [Extension]
        #
        # @api private
        def coerce_to_extensions(extensions = Undefined)
          if extensions.equal?(Undefined)
            Evaluator::Context.new(header) { |context| yield context }.functions
          else
            extensions
          end
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Extension
  end # module Algebra
end # module Veritas
