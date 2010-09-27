module Veritas
  module Algebra

    # Summarize a relation by specific attributes
    class Summarization < Relation
      include Relation::Operation::Unary

      # The relation to summarize by
      #
      # @return [Relation]
      #
      # @api private
      attr_reader :summarize_by

      # The summarizers for the relation
      #
      # @return [Hash]
      #
      # @api private
      attr_reader :summarizers

      # Initialize a Summarization
      #
      # @param [Relation] operand
      #   the relation to summarize
      # @param [Relation] summarize_by
      #   the relation to summarize by
      # @param [#to_hash] summarizers
      #   the summarizers to add
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, summarize_by, summarizers)
        super(operand)
        @summarize_by = summarize_by
        @summarizers  = summarizers.to_hash
        @header       = @summarize_by.header | @summarizers.keys
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   summarization = Summarization.new(self, relation, evaluator.expressions)
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
        header      = self.header
        summaries   = summarize_relation
        summarizers = self.summarizers.values

        summarize_by.each do |tuple|
          yield tuple.join(header, summaries[tuple].values_at(*summarizers))
        end

        self
      end

    private

      # Return the summaries for each tuple, grouped by the summarize_by header
      #
      # @return [Hash]
      #
      # @api private
      def summarize_relation
        header    = summarize_by.header
        summaries = {}

        operand.each do |tuple|
          summarize_tuple(tuple, summaries[tuple.project(header)] ||= {})
        end

        summaries
      end

      # Calculate the summary for each function and tuple
      #
      # @param [Tuple] tuple
      #   a tuple from the base relation
      # @param [Hash] summary
      #   the summary for a group of matching tuples
      #
      # @return [undefined]
      #
      # @api private
      def summarize_tuple(tuple, summary)
        summarizers.each_value do |summarizer|
          self.class.summarize(tuple, summary, summarizer)
        end
      end

      # Calculate the summary for a function and tuple
      #
      # @param [Tuple] tuple
      #   a tuple from the base relation
      # @param [Hash] summary
      #   the summary for a group of matching tuples
      # @param [#call] summarizer
      #   the function to call with the summary and tuple
      #
      # @return [self]
      #
      # @api private
      def self.summarize(tuple, summary, summarizer)
        summary[summarizer] = summarizer.call(summary[summarizer], tuple)
        self
      end

      module Methods

        # Return a summarized relation
        #
        # @example
        #   summarization = relation.summarize(relation.project([ :name ])) do |expression|
        #     expression.add(:count, expression[:name].count)
        #   end
        #
        # @yield [expression]
        #   Evaluate an summarization expression
        #
        # @yieldparam [Evaluator::Expression] expression
        #   the context to evaluate the summarization with
        #
        # @return [Summarization]
        #
        # @api public
        def summarize(summarize_by, &block)
          relation  = coerce_to_relation(summarize_by)
          evaluator = Evaluator::Expression.new(&block)
          Summarization.new(self, relation, evaluator.expressions)
        end

      private

        # Coerce the argument into a Relation
        #
        # @param [Relation, Header, #to_ary] summarize_by
        #   the relation, header or attributes to summarize by
        #
        # @return [Relation]
        #
        # @api private
        def coerce_to_relation(summarize_by)
          if summarize_by.kind_of?(Relation)
            summarize_by
          else
            project(Relation::Header.coerce(summarize_by))
          end
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Summarization
  end # module Algebra
end # module Veritas
