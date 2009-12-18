module Veritas
  class Relation
    attr_reader :header, :body

    def initialize(header, body)
      @header, @body = header, body
    end

    def union(other)
      Algebra::Union.new(self, other)
    end

    alias | union

    def ==(other)
      header == other.header &&
      body   == other.body
    end
  end # class Relation
end # module Veritas
