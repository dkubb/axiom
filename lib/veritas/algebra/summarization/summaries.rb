module Veritas
  module Algebra
    class Summarization

      # Summaries for all aggregate functions
      class Summaries

        # Initialize Summaries
        #
        # @param [Hash{Symbol => #call}] summarizers
        #
        # @return [undefined]
        #
        # @api private
        def initialize(summarizers)
          @summaries = {}
          summarizers.each do |name, summarizer|
            @summaries[name] = Summary.new(summarizer)
          end
        end

        # Execute all summarizers with the tuple, summarized by the header
        #
        # @example
        #   summaries = summaries.summarize_by(header, tuple)
        #
        # @param [Header] header
        #
        # @param [Tuple] tuple
        #
        # @return [self]
        #
        # @api public
        def summarize_by(header, tuple)
          projection = tuple.project(header)
          @summaries.each_value do |summary|
            summary.summarize_by(projection, tuple)
          end
          self
        end

        # Return the summaries as a Hash
        #
        # @example
        #   hash = summaries.to_hash
        #
        # @return [Hash]
        #
        # @api public
        def to_hash
          @summaries
        end

      end # class Summaries
    end # class Summarization
  end # module Algebra
end # module Veritas
