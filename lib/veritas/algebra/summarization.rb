module Veritas
  module Algebra
    class Summarization < Relation
      include Relation::Operation::Unary

      attr_reader :summarize_by, :summarizers

      def initialize(operand, summarize_by, summarizers)
        super(operand)
        @summarize_by = summarize_by
        @summarizers  = summarizers.to_hash
        @header       = @summarize_by.header | @summarizers.keys
      end

      def each
        header      = self.header
        summaries   = calculate_summaries
        summarizers = self.summarizers.values

        summarize_by.each do |tuple|
          yield tuple.join(header, summaries[tuple].values_at(*summarizers))
        end

        self
      end

    private

      def calculate_summaries
        header    = summarize_by.header
        summaries = {}

        operand.each do |tuple|
          summarize_tuple(tuple, summaries[tuple.project(header)] ||= {})
        end

        summaries
      end

      def summarize_tuple(tuple, summary)
        summarizers.each_value do |summarizer|
          self.class.summarize(tuple, summary, summarizer)
        end
      end

      def self.summarize(tuple, summary, summarizer)
        summary[summarizer] = summarizer.call(summary[summarizer], tuple)
        self
      end

      module Methods
        def summarize(summarize_by, &block)
          relation  = summarize_by_relation(summarize_by)
          evaluator = Evaluator::Expression.new(&block)
          Summarization.new(self, relation, evaluator.expressions)
        end

      private

        def summarize_by_relation(summarize_by)
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
