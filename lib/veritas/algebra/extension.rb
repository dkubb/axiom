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
        header     = self.header
        extensions = self.extensions.values
        operand.each { |operand_tuple| yield operand_tuple.extend(header, extensions) }
        self
      end

      module Methods

        # Return an extended relation
        #
        # @example
        #   extension = relation.extend do |context|
        #     context.add(:total, context[:unit_price] * context[:quantity])
        #   end
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
        # @api public
        def extend(extensions = Undefined)
          if extensions.equal?(Undefined)
            context    = Evaluator::Context.new(header) { |context| yield context }
            extensions = context.functions
          end
          Extension.new(self, extensions)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Extension
  end # module Algebra
end # module Veritas
