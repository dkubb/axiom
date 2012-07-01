# encoding: utf-8

module Veritas

  # Abstract base class for Relation operations
  class Relation
    include Immutable, Enumerable, Visitable
    include Equalizer.new(:header, :to_set)

    # The relation header
    #
    # @return [Header]
    #
    # @api private
    attr_reader :header

    # The relation tuples
    #
    # @return [Enumerable]
    #
    # @api private
    attr_reader :tuples
    private :tuples

    # The relation sort order
    #
    # @return [Operation::Order::DirectionSet]
    #
    # @api private
    def directions
      Operation::Order::DirectionSet::EMPTY
    end

    # Instantiate a new Relation
    #
    # @example of a materialized Array based relation
    #   array    = [ [ 1 ], [ 2 ], [ 3 ] ]
    #   relation = Relation.new([ [ :id, Integer ] ], array)
    #
    # @example of a materialized Set based relation
    #   set      = Set[ [ 1 ], [ 2 ], [ 3 ] ]
    #   relation = Relation.new([ [ :id, Integer ] ], set)
    #
    # @example of a non-materialized Enumerator based relation
    #   enumerator = [ [ 1 ], [ 2 ], [ 3 ] ].each
    #   relation   = Relation.new([ [ :id, Integer ] ], enumerator)
    #
    # @param [Header, #to_ary] header
    #   the relation header
    # @param [Enumerable] tuples
    #   the relation tuples
    #
    # @return [Relation]
    #
    # @api public
    def self.new(*args)
      if equal?(Relation) && args.last.respond_to?(:size)
        Materialized.new(*args)
      else
        super
      end
    end

    # Initialize a Relation
    #
    # @param [Header, #to_ary] header
    #   the relation header
    # @param [Enumerable] tuples
    #   the relation tuples
    #
    # @return [undefined]
    #
    # @api private
    def initialize(header, tuples)
      @header = Header.coerce(header)
      @tuples = tuples
    end

    # Lookup an Attribute in the header given an attribute name
    #
    # @example
    #   attribute = relation[name]
    #
    # @param [#to_sym] name
    #   the attribute name
    #
    # @return [Attribute]
    #
    # @api public
    def [](name)
      header[name]
    end

    # Iterate over each tuple in the set
    #
    # @example
    #   relation = Relation.new(header, tuples)
    #   relation.each { |tuple| ... }
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
      return to_enum unless block_given?
      seen = {}
      tuples.each do |tuple|
        tuple = Tuple.coerce(header, tuple)
        yield seen[tuple] = tuple unless seen.key?(tuple)
      end
      self
    end

    # Return a tuple if the relation contains exactly one tuple
    #
    # @example
    #   tuple = relation.one
    #
    # @raise [NoTuplesError]
    #   raised if no tuples are returned
    # @raise [ManyTuplesError]
    #   raised if more than one tuple is returned
    #
    # @api public
    def one
      tuples = to_a
      assert_exactly_one_tuple(tuples.size)
      tuples.first
    end

    # Return a relation that represents a replacement of a relation
    #
    # Delete the tuples from the relation that are not in the other relation,
    # then insert only new tuples.
    #
    # @example
    #   replacement = relation.delete(other)
    #
    # @param [Enumerable] other
    #
    # @return [Relation::Operation::Insertion]
    #
    # @api public
    def replace(other)
      other = coerce(other)
      delete(difference(other)).insert(other.difference(self))
    end

    # Return a relation with each tuple materialized
    #
    # @example
    #   materialized = relation.materialize
    #
    # @return [Materialized]
    #
    # @api public
    def materialize
      Materialized.new(header, to_a, directions)
    end

    # Return false for a non-Materialized relation
    #
    # @example
    #   relation.materialized?  # => false
    #
    # @return [false]
    #
    # @api public
    def materialized?
      false
    end

    # Compare the relation with other relation for equivalency
    #
    # @example
    #   relation == other  # => true or false
    #
    # @param [Relation] other
    #   the other relation to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      other = coerce(other)
      header == other.header &&
      to_set == other.to_set
    end

    # Test if there are no tuples
    #
    # @example
    #   relation.empty?  # => true or false
    #
    # @return [Boolean]
    #
    # @api public
    def empty?
      none? { true }
    end

  private

    # Coerce an Enumerable into a Relation
    #
    # @param [Enumerable] object
    #   the object to coerce
    #
    # @return [Relation]
    #
    # @api private
    def coerce(object)
      self.class.coerce(header, object)
    end

    # Coerce an Enumerable into a Relation
    #
    # @param [Header] header
    #   the header to use when initializing a Relation
    # @param [Enumerable] object
    #   the object to coerce
    #
    # @return [Relation]
    #
    # @api private
    def self.coerce(header, object)
      object.kind_of?(Relation) ? object : Relation.new(header, object)
    end

    # Assert exactly one tuple is returned
    #
    # @return [undefined]
    #
    # @raise [NoTuplesError]
    #   raised if no tuples are returned
    # @raise [ManyTuplesError]
    #   raised if more than one tuple is returned
    #
    # @api private
    def assert_exactly_one_tuple(size)
      if size.zero?
        raise NoTuplesError, 'one tuple expected, but was an empty set'
      elsif size > 1
        raise ManyTuplesError,
          "one tuple expected, but set contained #{size} tuples"
      end
    end

  end # class Relation
end # module Veritas
