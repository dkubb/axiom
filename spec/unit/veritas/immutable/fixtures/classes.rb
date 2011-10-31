# encoding: utf-8

module ImmutableSpecs
  class Object
    include Immutable

    def test
      'test'
    end

    def public_method
      caller
    end

  protected

    def protected_method
      caller
    end

  private

    def private_method
      caller
    end

  end # class Object
end # module ImmutableSpecs
