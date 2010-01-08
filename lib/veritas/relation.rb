require 'veritas/relation/body'
require 'veritas/relation/header'
require 'veritas/relation/operation'

module Veritas
  class Relation
    include Enumerable

    attr_reader :header, :body

    def initialize(header, body)
      @header = Header.new(header)
      @body   = Body.new(@header, body)
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
      Algebra::Project.new(self, attributes)
    end

    def remove(attributes)
      Algebra::Project.new(self, header - project_header(attributes))
    end

    def rename(aliases)
      Algebra::Rename.new(self, aliases)
    end

    def restrict(predicate = nil, &block)
      Algebra::Restriction.new(self, predicate, &block)
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

    def order(directions = nil, &block)
      Operation::Order.new(self, directions, &block)
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

    def theta_join(other, predicate, &block)
      product(other).restrict(predicate, &block)
    end

  end # class Relation
end # module Veritas
