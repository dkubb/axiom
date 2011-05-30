# encoding: utf-8

module Veritas
  module Algebra

    # Summarize a relation by specific attributes
    class Summarization < Relation
      include Relation::Operation::Unary

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
      # @param [#to_hash] summarizers
      #   the summarizers to add
      #
      # @return [Summarization]
      #
      # @api public
      def self.new(operand, summarize_per, summarizers)
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
        @summarizers   = summarizers.to_hash
        @header        = @summarize_per.header | @summarizers.keys
        @directions    = Relation::Operation::Order::DirectionSet::EMPTY
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
        Extension.new(summarize_per, summaries).each { |tuple| yield tuple }
        self
      end

      # Compare the Summarization with other relation for equality
      #
      # @example
      #   summarization.eql?(other)  # => true or false
      #
      # @param [Relation] other
      #   the other relation to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        super                                   &&
        summarize_per.eql?(other.summarize_per) &&
        summarizers.eql?(other.summarizers)
      end

      # Return the hash of the summarization
      #
      # @example
      #   hash = summarization.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        super ^ summarize_per.hash ^ summarizers.hash
      end

    private

      # Return the current summaries
      #
      # @return [Summaries]
      #
      # @api private
      def summaries
        header    = summarize_per.header
        summaries = default_summaries
        operand.each { |tuple| summaries.summarize_by(header, tuple) }
        summaries
      end

      # Return the default summaries
      #
      # @return [Summaries]
      #
      # @api private
      def default_summaries
        Summaries.new(summarizers)
      end

      module Methods

        # Return a summarized relation
        #
        # @example with a relation
        #   summarization = relation.summarize(relation.project([ :name ])) do |context|
        #     context.add(:count, context[:name].count)
        #   end
        #
        # @example with a header
        #   summarization = relation.summarize([ :name ]) do |context|
        #     context.add(:count, context[:name].count)
        #   end
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
        def summarize(summarize_with)
          summarize_per = coerce_to_relation(summarize_with)
          context       = Evaluator::Context.new(header - summarize_per.header) { |context| yield context }
          Summarization.new(self, summarize_per, context.functions)
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
            project(Relation::Header.coerce(summarize_with))
          end
        end

      end # module Methods

      Relation.class_eval { include Methods }

      memoize :hash

    end # class Summarization
  end # module Algebra
end # module Veritas
