module Veritas
  module Algebra
    class Summarization

      # The summary for an aggregate function grouped by tuple
      class Summary

        # Initialize a Summary
        #
        # @param [#call] summarizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(summarizer)
          @summarizer = summarizer
          @summary    = {}  # mutable
        end

        # Summarize the aggregate function by a tuple
        #
        # @example
        #   summary = summary.summarize_by(projection, tuple)
        #
        # @param [Tuple] projection
        #   the tuple projection to summarize the results by
        # @param [Tuple] tuple
        #   the tuple to execute the aggregate function with
        #
        # @return [self]
        #
        # @api public
        def summarize_by(projection, tuple)
          @summary[projection] = @summarizer.call(@summary[projection], tuple)
          self
        end

        # Return the finalized summary for a tuple
        #
        # @example
        #   object = summary.call(tuple)
        #
        # @param [Tuple] tuple
        #
        # @return [Object]
        #
        # @api public
        def call(tuple)
          @summary[tuple]
        end

      end # class Summary
    end # class Summarization
  end # module Algebra
end # module Veritas
