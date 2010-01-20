require 'veritas/relation/header'
require 'veritas/relation/operation'

module Veritas
  class Relation
    include Enumerable
    include Optimizable

    attr_reader :header

    def initialize(header, tuples)
      @header, @tuples = Header.coerce(header), tuples
    end

    def [](name)
      header[name]
    end

    def each
      seen = {}
      @tuples.each do |tuple|
        tuple = Tuple.coerce(header, tuple)
        yield(seen[tuple] = tuple) unless seen.key?(tuple)
      end
      self
    end

    def empty?
      each { return false }
      true
    end

    def project(attributes)
      project_relation(self, attributes)
    end

    def remove(attributes)
      project(header - project_header(attributes))
    end

    def rename(aliases)
      Algebra::Rename.new(self, aliases)
    end

    def restrict(predicate = yield(self))
      Algebra::Restriction.new(self, predicate)
    end

    def join(other, predicate = nil, &block)
      if predicate || block_given?
        theta_join(other, predicate, &block)
      else
        natural_join(other)
      end
    end

    alias + join

    def product(other)
      Algebra::Product.new(self, other)
    end

    alias * product

    def intersect(other)
      Algebra::Intersection.new(self, other)
    end

    alias & intersect

    def union(other)
      Algebra::Union.new(self, other)
    end

    alias | union

    def difference(other)
      Algebra::Difference.new(self, other)
    end

    alias - difference

    def order(directions = yield(self))
      Operation::Order.new(self, directions)
    end

    def limit(limit)
      Operation::Limit.new(self, limit)
    end

    alias take limit

    def offset(offset)
      Operation::Offset.new(self, offset)
    end

    alias drop offset

    def first(limit = 1)
      limit(limit)
    end

    def last(limit = 1)
      reverse.first(limit).reverse
    end

    def reverse
      Operation::Reverse.new(self)
    end

    def directions
      @directions ||= Operation::Order::DirectionSet.new([])
    end

    def ==(other)
      other = coerce(other)
      header == other.header &&
      to_set == project_relation(other).to_set
    end

    def eql?(other)
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      to_set.eql?(project_relation(other).to_set)
    end

  private

    def project_header(attributes)
      header.project(attributes)
    end

    def project_relation(relation, attributes = header)
      Algebra::Projection.new(relation, attributes)
    end

    def natural_join(other)
      Algebra::Join.new(self, other)
    end

    def theta_join(other, *args, &block)
      product(other).restrict(*args.compact, &block)
    end

    def coerce(tuples)
      tuples.kind_of?(Relation) ? tuples : Relation.new(header, tuples)
    end

  end # class Relation
end # module Veritas
