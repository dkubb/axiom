# encoding: utf-8

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
        @directions   = Relation::Operation::Order::DirectionSet::EMPTY
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
      def each(&block)
        return to_enum unless block_given?
        Extension.new(summarize_by, summaries).each(&block)
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
        super                                 &&
        summarize_by.eql?(other.summarize_by) &&
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
        super ^ summarize_by.hash ^ summarizers.hash
      end

    private

      # Return the current summaries
      #
      # @return [Summaries]
      #
      # @api private
      def summaries
        header    = summarize_by.header
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
        # @example with a projection
        #   summarization = relation.summarize(relation.project([ :name ])) do |context|
        #     context.add(:count, context[:name].count)
        #   end
        #
        # @example with a header
        #   summarization = relation.summarize([ :name ]) do |context|
        #     context.add(:count, context[:name].count)
        #   end
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
        def summarize(summarize_by, &block)
          relation = coerce_to_relation(summarize_by)
          context  = Evaluator::Context.new(self, &block)
          Summarization.new(self, relation, context.functions)
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

      memoize :hash

    end # class Summarization
  end # module Algebra
end # module Veritas
