module Veritas

  # A set of objects representing a unique fact in a relation
  class Tuple
    include Immutable

    # The tuple header
    #
    # @return [Header]
    #
    # @api private
    attr_reader :header

    # Initialize a Tuple
    #
    # @param [Header] header
    #   the tuple header
    # @param [#to_ary] data
    #   the tuple data
    #
    # @return [undefined]
    #
    # @api private
    def initialize(header, data)
      @header, @data = header, data.to_ary
    end

    # Lookup a value in the tuple given an attribute
    #
    # @example
    #   value = tuple[attribute]
    #
    # @param [Attribute] attribute
    #
    # @return [Object]
    #
    # @api public
    def [](attribute)
      index = header.index(attribute)
      to_ary.at(index) if index
    end

    # Return a tuple with only the specified attributes
    #
    # @example
    #   new_tuple = tuple.project(header)
    #
    # @param [Header] header
    #   the attributes to include in the tuple
    #
    # @return [Tuple]
    #
    # @api public
    def project(header)
      self.class.new(header, header.map { |attribute| self[attribute] })
    end

    # Append values to the tuple and return a new tuple
    #
    # @example
    #   new_tuple = tuple.join(header, [ 1, 2, 3 ])
    #
    # @param [Header] header
    #   the attributes to include in the tuple
    # @param [Array] values
    #   the values to append
    #
    # @return [Tuple]
    #
    # @api public
    def join(header, values)
      self.class.new(header, to_ary + values)
    end

    # Extend a tuple with function results
    #
    # @example
    #   new_tuple = tuple.extend(header, [ func1, func2 ])
    #
    # @param [Header] header
    #   the attributes to include in the tuple
    # @param [Array<#call>] extensions
    #   the functions to extend the tuple with
    #
    # @return [Tuple]
    #
    # @api public
    def extend(header, extensions)
      join(header, extensions.map { |extension| extension.call(self) })
    end

    # Convert the Tuple into an Array
    #
    # @example
    #   array = tuple.to_ary
    #
    # @return [Array]
    #
    # @api public
    def to_ary
      @data
    end

    # Compare the tuple with other tuple for equivalency
    #
    # @example
    #   tuple.eql?(other)  # => true or false
    #
    # @param [Tuple] other
    #   the other tuple to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      header = self.header
      other  = self.class.coerce(header, other)
      header == other.header &&
      to_ary == other.project(header).to_ary
    end

    # Compare the tuple with other tuple for equality
    #
    # @example
    #   tuple == other  # => true or false
    #
    # @param [Tuple] other
    #   the other tuple to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      header = self.header
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      to_ary.eql?(other.project(header).to_ary)
    end

    # Return the hash of the tuple
    #
    # @example
    #   numeric_hash = tuple.hash
    #
    # @return [Integer]
    #
    # @api public
    def hash
      header.hash ^ to_ary.hash
    end

    # Return a string representing the tuple data
    #
    # @example
    #   tuple.inspect  # => "[1, 2, 3]"
    #
    # @return [String]
    #
    # @api public
    def inspect
      to_ary.inspect
    end

    # Coerce an Array-like object into a Tuple
    #
    # @example
    #   tuple = Tuple.coerce(header, [ 1, 2, 3 ])
    #
    # @param [Header] header
    #   the tuple header
    # @param [Tuple, #to_ary]
    #   the tuple or tuple data
    #
    # @return [Tuple]
    #
    # @api public
    def self.coerce(header, object)
      object.kind_of?(Tuple) ? object : new(header, object)
    end

    memoize :hash

  end # class Tuple
end # module Veritas
