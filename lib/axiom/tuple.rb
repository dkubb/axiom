# encoding: utf-8

module Axiom

  # A set of objects representing a unique fact in a relation
  class Tuple
    extend Aliasable
    include Equalizer.new(:data)

    inheritable_alias(:[] => :fetch)

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

    # Convert the Tuple into an Array
    #
    # @example
    #   array = tuple.to_ary
    #
    # @return [Array]
    #
    # @api public
    attr_reader :to_ary

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
      @to_ary = self.class.freezer.call(data)
      @data   = Hash[header.zip(@to_ary)]
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
    def fetch(attribute)
      data.fetch(header.fetch(attribute))
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

    # Extend a tuple with function results
    #
    # @example
    #   new_tuple = tuple.extend(header, [func1, func2])
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

    # Rename a tuple to use a new header
    #
    # @example
    #   new_tuple = tuple.rename(header)
    #
    # @param [Header] header
    #
    # @return [Tuple]
    #
    # @api public
    def rename(header)
      self.class.new(header, to_ary)
    end

    # Append values to the tuple and return a new tuple
    #
    # @example
    #   new_tuple = tuple.join(header, [1, 2, 3])
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

    # Coerce the tuple into a Hash
    #
    # @example
    #   tuple.to_hash  # => data as a Hash
    #
    # @return [Hash{Symbol => Object}]
    #
    # @api public
    def to_hash
      Hash[data.map { |attribute, value| [attribute.name, value] }]
    end

    # The number of attributes
    #
    # @return [Integer]
    #
    # @api public
    def size
      header.size
    end

    # Display the tuple data in a human readable form
    #
    # @example
    #   tuple.inspect  # => data as a String
    #
    # @return [String]
    #
    # @api public
    def inspect
      to_hash.inspect
    end

  private

    # Coerce an Array-like object into a Tuple
    #
    # @param [Tuple, #to_ary] object
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
    # @param [Tuple, #to_ary] object
    #   the tuple or tuple data
    #
    # @return [Tuple]
    #
    # @api private
    def self.coerce(header, object)
      if object.kind_of?(Tuple) || header.size != object.to_ary.size
        object
      else
        new(header, object)
      end
    end

    memoize :predicate, :to_hash, :inspect

  end # class Tuple
end # module Axiom
