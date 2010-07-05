module ImmutableSpecs
  class Object
    include Immutable

    def test
      rand
    end

    def public_method
      rand
    end

  protected

    def protected_method
      rand
    end

  private

    def private_method
      rand
    end

  end # class Object
end # module ImmutableSpecs
