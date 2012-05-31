# encoding: utf-8

# Extend Range with methods to normalize and find overlapping ranges
class Range

  unless method_defined?(:to_inclusive)
    # Returns an inclusive Range
    #
    # @example
    #   inclusive = range.to_inclusive
    #
    # @return [Range]
    #
    # @api public
    def to_inclusive
      if exclude_end?
        self.class.new(first, last.pred)
      else
        self
      end
    end
  end

  unless method_defined?(:overlaps?)
    # Compare the range with another range to see if they overlap
    #
    # @example
    #   range.overlaps?(other)  # => true or false
    #
    # @param [Range] other
    #   the other Range to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def overlaps?(other)
      cover?(other.first) || other.cover?(first)
    end
  end

end # class Range
