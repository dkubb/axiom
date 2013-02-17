# encoding: utf-8

module Veritas
  module Algebra

    # Summarize a relation by specific attributes
    class Summarization < Relation
      include Relation::Operation::Unary
      include Equalizer.new(:operand, :summarize_per, :summarizers)

      # The relation to summarize with
      #
      # @return [Relation]
      #
      # @api private
      attr_reader :summarize_per

      # The summarizers for the relation
      #
      # @return [Hash]
      #
      # @api private
      attr_reader :summarizers

      # Instantiate a new Summarization
      #
      # @example
      #   summarization = Summarization.new(operand, summarize_per, summarizers)
      #
      # @param [Relation] operand
      #   the relation to summarize
      # @param [Relation] summarize_per
      #   the relation to summarize with
      # @param [#to_hash] _summarizers
      #   the summarizers to add
      #
      # @return [Summarization]
      #
      # @api public
      def self.new(operand, summarize_per, _summarizers)
        assert_subset_headers(operand, summarize_per)
        super
      end

      # Assert the summarize_per header is a subset of the operand header
      #
      # @param [Relation] operand
      # @param [Relation] summarize_per
      #
      # @return [undefined]
      #
      # @raise [InvalidHeaderError]
      #   raised if the summarize_per header is not a subset of the operand header
      #
      # @api private
      def self.assert_subset_headers(operand, summarize_per)
        unless summarize_per.header.to_set.proper_subset?(operand.header.to_set)
          raise InvalidHeaderError, 'the summarize_per header must be a proper subset of the operand header'
        end
      end

      private_class_method :assert_subset_headers

      # Initialize a Summarization
      #
      # @param [Relation] operand
      #   the relation to summarize
      # @param [Relation] summarize_per
      #   the relation to summarize with
      # @param [#to_hash] summarizers
      #   the summarizers to add
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, summarize_per, summarizers)
        super(operand)
        @summarize_per = summarize_per
        @summarizers   = summarizers
        @header        = @summarize_per.header | @summarizers.keys
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   summarization = Summarization.new(self, relation, context.functions)
      #   summarization.each { |tuple| ... }
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
        summarize_per.extend(summaries).each { |tuple| yield tuple }
        self
      end

      # Raise an exception when inserting into a Summarization
      #
      # @example
      #   summarization.insert(other)  # => ImmutableRelationError raised
      #
      # @return [undefined]
      #
      # @raise [ImmutableRelationError]
      #   raised when inserting into the summarization
      #
      # @api public
      def insert(*)
        raise ImmutableRelationError, 'inserting into a summarization is impossible'
      end

      # Raise an exception when deleting from a Summarization
      #
      # @example
      #   summarization.delete(other)  # => ImmutableRelationError raised
      #
      # @return [undefined]
      #
      # @raise [ImmutableRelationError]
      #   raised when deleting from the summarization
      #
      # @api public
      def delete(*)
        raise ImmutableRelationError, 'deleting from a summarization is impossible'
      end

    private

      # Return the current summaries
      #
      # @return [Hash]
      #
      # @api private
      def summaries
        summaries = default_summaries
        operand.each { |tuple| summaries.summarize_by(tuple) }
        summaries.to_hash
      end

      # Return the default summaries
      #
      # @return [Summaries]
      #
      # @api private
      def default_summaries
        Summaries.new(summarize_per.header, summarizers)
      end

      module Methods

        # Return a summarized relation
        #
        # @example with no arguments
        #   summarization = relation.summarize do |context|
        #     context.add(:count, context[:id].count)
        #   end
        #
        # @example with a relation
        #   summarization = relation.summarize(relation.project([ :name ])) do |context|
        #     context.add(:count, context[:id].count)
        #   end
        #
        # @example with a header
        #   summarization = relation.summarize([ :name ]) do |context|
        #     context.add(:count, context[:id].count)
        #   end
        #
        # @example with summarizers
        #   summarization = relation.summarize([ :name ], summarizers)
        #
        # @param [Relation, Header, #to_ary] summarize_with
        #
        # @yield [function]
        #   Evaluate a summarization function
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the function within
        #
        # @return [Summarization]
        #
        # @api public
        def summarize(summarize_with = TABLE_DEE, *args, &block)
          summarize_per = coerce_to_relation(summarize_with)
          summarizers   = coerce_to_summarizers(summarize_per, *args, &block)
          Summarization.new(self, summarize_per, summarizers)
        end

      private

        # Coerce the argument into a Relation
        #
        # @param [Relation, Header, #to_ary] summarize_with
        #   the relation, header or attributes to summarize with
        #
        # @return [Relation]
        #
        # @api private
        def coerce_to_relation(summarize_with)
          if summarize_with.kind_of?(Relation)
            summarize_with
          else
            project(summarize_with)
          end
        end

        # Coerce the arguments and block into summarizers
        #
        # @param [#header] summarize_per
        #   the Relation to summarize with
        # @param [Hash] summarizers
        #   optional summarizers
        #
        # @yield [function]
        #   Evaluate a summarization function
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the function within
        #
        # @return [#to_hash]
        #
        # @api private
        def coerce_to_summarizers(summarize_per, summarizers = Undefined)
          if summarizers.equal?(Undefined)
            Evaluator::Context.new(header - summarize_per.header) { |context|
              yield context
            }.functions
          else
            summarizers
          end
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Summarization
  end # module Algebra
end # module Veritas
