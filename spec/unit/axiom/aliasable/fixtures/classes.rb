# encoding: utf-8

module AliasableSpecs
  class Object
    extend Aliasable

    def test; end

    def test_with_arguments(a, b)
      [a, b]
    end

    def test_with_block(&block)
      block
    end
  end # class Object
end # module AliasableSpecs
