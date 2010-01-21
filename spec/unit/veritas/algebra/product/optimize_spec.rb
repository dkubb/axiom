require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#optimize' do
  before do
    @left   = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right  = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { @product.optimize }

  describe 'left has and empty header' do
    before do
      @left = Relation.new([], [])

      @product = Algebra::Product.new(@left, @right)
    end

    it { should equal(@right) }
  end

  describe 'right has and empty header' do
    before do
      @right = Relation.new([], [])

      @product = Algebra::Product.new(@left, @right)
    end

    it { should equal(@left) }
  end

  describe 'left and right do not have empty headers' do
    before do
      @product = Algebra::Product.new(@left, @right)
    end

    it { should equal(@product) }
  end
end
