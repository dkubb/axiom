# encoding: utf-8

module ImmutableSpecs
  class Object
    include Immutable

    def test
      'test'
    end

    def public_method
      'public_method'
    end

  protected

    def protected_method
      'protected_method'
    end

  private

    def private_method
      'private_method'
    end

  end # class Object
end # module ImmutableSpecs
