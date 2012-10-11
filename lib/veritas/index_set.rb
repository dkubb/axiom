module Veritas
  # Represents a set of index attributes
  #
  class IndexSet

    # Initialize the index set
    #
    # @param [Tuple] tuple
    #
    # @return [undefined]
    #
    # @api private
    def initialize(tuple)
      @index  = Hash[
        tuple.header.indices.group_by(&:index).map { |name, attributes|
          [ name, tuple.project(attributes) ]
        }
      ]
    end

    # Return index tuple referenced by the index name
    #
    # @example
    #   index_set[:item] # => Tuple
    #
    # @param [String] index group name
    #
    # @return [Tuple]
    #
    # @api public
    def [](name)
      @index[name]
    end

  end # class IndexSet
end # module Veritas
