require 'veritas/relation/body'
require 'veritas/relation/header'

module Veritas
  class Relation
    include Enumerable

    attr_reader :header, :body

    def initialize(header, body)
      @header = Header.new(header)
      @body   = Body.new(@header, body)
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
      header = self.header
      Algebra::Project.new(self, header - header.project(attributes))
    end

    def rename(aliases)
      Algebra::Rename.new(self, aliases)
    end

    def restrict(&block)
      Algebra::Restriction.new(self, &block)
    end

    def join(other)
      Algebra::Join.new(self, other)
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

    def ==(other)
      header == other.header &&
      body   == other.body
    end

    def eql?(other)
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      body.eql?(other.body)
    end

  end # class Relation
end # module Veritas
