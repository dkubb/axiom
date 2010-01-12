require 'veritas/relation/body'
require 'veritas/relation/header'
require 'veritas/relation/operation'
require 'veritas/relation/set'

module Veritas
  class Relation
    include Enumerable

    attr_reader :header, :body

    def initialize(attributes, tuples)
      @header = Header.new(attributes)
      @body   = Body.new(@header, tuples)
    end

    def [](name)
      header[name]
    end

    def each(&block)
      body.each(&block)
      self
    end

    def empty?
      body.empty?
    end

    def project(attributes)
      Algebra::Projection.new(self, attributes)
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
      Operation::Order.new(self, Array(directions))
    end

    # TODO: limit this to only be available to ordered relations, and containers
    def limit(limit)
      Operation::Limit.new(self, limit.to_int)
    end

    # TODO: limit this to only be available to ordered relations, and containers
    def offset(offset)
      Operation::Offset.new(self, offset.to_int)
    end

    def ==(other)
      header == other.header &&
      body   == other.body
    end

    def eql?(other)
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      body.eql?(other.body)
    end

  private

    def project_header(attributes)
      header.project(attributes)
    end

    def natural_join(other)
      Algebra::Join.new(self, other)
    end

    def theta_join(other, *args, &block)
      product(other).restrict(*args.compact, &block)
    end

  end # class Relation
end # module Veritas
