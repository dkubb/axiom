# encoding: utf-8

module Axiom

  # Abstract base class for Relation operations
  class Relation
    include Enumerable, Visitable, Adamantium::Flat
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
    # @return [Operation::Sorted::DirectionSet]
    #
    # @api private
    def directions
      Operation::Sorted::DirectionSet::EMPTY
    end

    # Instantiate a new Relation
    #
    # @example of a materialized Array based relation
    #   array    = [[1], [2], [3]]
    #   relation = Relation.new([[:id, Integer]], array)
    #
    # @example of a materialized Set based relation
    #   set      = Set[[1], [2], [3]]
    #   relation = Relation.new([[:id, Integer]], set)
    #
    # @example of a non-materialized Enumerator based relation
    #   enumerator = [[1], [2], [3]].each
    #   relation   = Relation.new([[:id, Integer]], enumerator)
    #
    # @param [Array(Header, Enumerable)] args
    #
    # @return [Relation]
    #
    # @api public
    def self.new(*args)
      if equal?(Relation) && materialized?(args[1])
        Materialized.new(*args)
      else
        super
      end
    end

    # Test if the tuples are materialized
    #
    # When tuples are nil, it means there are no tuples so it is the equivalent
    # of specifying [] for the tuples.
    #
    # @param [Enumerable, nil] tuples
    #
    # @return [Boolean]
    #
    # @api private
    def self.materialized?(tuples)
      tuples.nil? || tuples.respond_to?(:size) && tuples.size.kind_of?(Integer)
    end
    private_class_method :materialized?

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

    # Test if the tuple exists in the relation
    #
    # @example
    #   relation.include?(tuple)  # => true or false
    #
    # @param [Tuple] tuple
    #
    # @return [Boolean]
    #
    # @api public
    def include?(tuple)
      to_set.include?(tuple)
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
      other.kind_of?(Relation) &&
      header == other.header   &&
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
      none?
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
      if object.kind_of?(Relation) || !object.kind_of?(Enumerable)
        object
      else
        Relation.new(header, object)
      end
    end

  end # class Relation
end # module Axiom
