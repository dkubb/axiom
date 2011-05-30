# encoding: utf-8

module Veritas
  module Algebra

    # Extend a relation to include calculated attributes
    class Extension < Relation
      include Relation::Operation::Unary

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
        @extensions  = extensions.to_hash
        @header     |= @extensions.keys
        @directions  = Relation::Operation::Order::DirectionSet::EMPTY
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
        header     = self.header
        extensions = self.extensions.values
        operand.each { |operand_tuple| yield operand_tuple.extend(header, extensions) }
        self
      end

      # Compare the Extension with other relation for equality
      #
      # @example
      #   extension.eql?(other)  # => true or false
      #
      # @param [Relation] other
      #   the other relation to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        super && extensions.eql?(other.extensions)
      end

      # Return the hash of the projection
      #
      # @example
      #   hash = extension.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        super ^ extensions.hash
      end

      module Methods

        # Return an extended relation
        #
        # @example
        #   extension = relation.extend do |context|
        #     context.add(:total, context[:unit_price] * context[:quantity])
        #   end
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
        def extend
          context = Evaluator::Context.new(header) { |context| yield context }
          Extension.new(self, context.functions)
        end

      end # module Methods

      Relation.class_eval { include Methods }

      memoize :hash

    end # class Extension
  end # module Algebra
end # module Veritas
