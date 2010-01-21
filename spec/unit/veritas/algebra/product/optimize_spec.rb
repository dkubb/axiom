require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product#optimize' do
  before do
    @left   = Relation.new([ [ :id,   Integer ] ], [ [ 1 ] ])
    @right  = Relation.new([ [ :name, String  ] ], [ [ 'Dan Kubb' ] ])
  end

  subject { @product.optimize }

  describe 'left is a TABLE_DUM' do
    before do
      @product = Algebra::Product.new(TABLE_DUM, @right)
    end

    it { should be_kind_of(Relation::Empty) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'right is a TABLE_DUM' do
    before do
      @product = Algebra::Product.new(@left, TABLE_DUM)
    end

    it { should be_kind_of(Relation::Empty) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'left is a TABLE_DUM when optimized' do
    before do
      @product = Algebra::Product.new(TABLE_DUM.project([]), @right)
    end

    it { should be_kind_of(Relation::Empty) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'right is a TABLE_DUM when optimized' do
    before do
      @product = Algebra::Product.new(@left, TABLE_DUM.project([]))
    end

    it { should be_kind_of(Relation::Empty) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'left is a TABLE_DEE' do
    before do
      @product = Algebra::Product.new(TABLE_DEE, @right)
    end

    it { should equal(@right) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'right is a TABLE_DEE' do
    before do
      @product = Algebra::Product.new(@left, TABLE_DEE)
    end

    it { should equal(@left) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'left is a TABLE_DEE when optimized' do
    before do
      @product = Algebra::Product.new(TABLE_DEE.project([]), @right)
    end

    it { should equal(@right) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'right is a TABLE_DEE when optimized' do
    before do
      @product = Algebra::Product.new(@left, TABLE_DEE.project([]))
    end

    it { should equal(@left) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @product
    end
  end

  describe 'left and right are normal relations' do
    before do
      @product = Algebra::Product.new(@left, @right)
    end

    it { should equal(@product) }
  end
end
