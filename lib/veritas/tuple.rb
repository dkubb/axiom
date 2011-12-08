# encoding: utf-8

module Veritas

  # A set of objects representing a unique fact in a relation
  class Tuple
    extend Aliasable, Comparator
    include Immutable

    inheritable_alias(:[] => :call)

    compare :data

    # The tuple header
    #
    # @return [Header]
    #
    # @api private
    attr_reader :header

    # The tuple data
    #
    # @return [Hash]
    #
    # @api private
    attr_reader :data

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
      @header = header
      @data   = Hash[header.zip(data.to_ary)].freeze
    end

    # Lookup a value in the tuple given an attribute
    #
    # @example
    #   value = tuple.call(attribute)
    #
    # @param [Attribute] attribute
    #
    # @return [Object]
    #
    # @api public
    def call(attribute)
      data.fetch(header.call(attribute))
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
      self.class.new(header, data.values_at(*header))
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
    # @param [Array<Object>] extensions
    #   the functions to extend the tuple with
    #
    # @return [Tuple]
    #
    # @api public
    def extend(header, extensions)
      join(
        header,
        extensions.map { |extension| Function.extract_value(extension, self) }
      )
    end

    # Return the predicate matching the tuple
    #
    # @return [Function]
    #
    # @api private
    def predicate
      header.reduce(Function::Proposition::Tautology.instance) do |predicate, attribute|
        predicate.and(attribute.eq(attribute.call(self)))
      end
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
      data.values_at(*header).freeze
    end

    # Compare the tuple with other tuple for equivalency
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
    def ==(other)
      cmp?(__method__, coerce(other))
    end

    # Return a string representing the tuple data
    #
    # @example
    #   tuple.inspect  # => "{<Attribute::Integer name: id>=>1}"
    #
    # @return [String]
    #
    # @api public
    def inspect
      data.inspect
    end

  private

    # Coerce an Array-like object into a Tuple
    #
    # @param [Header] header
    #   the tuple header
    # @param [Tuple, #to_ary]
    #   the tuple or tuple data
    #
    # @return [Tuple]
    #
    # @api private
    def coerce(object)
      self.class.coerce(header, object)
    end

    # Coerce an Array-like object into a Tuple
    #
    # @param [Header] header
    #   the tuple header
    # @param [Tuple, #to_ary]
    #   the tuple or tuple data
    #
    # @return [Tuple]
    #
    # @api private
    def self.coerce(header, object)
      object.kind_of?(Tuple) ? object : new(header, object)
    end

    memoize :predicate, :to_ary

  end # class Tuple
end # module Veritas
