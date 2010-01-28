require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = @relation.order(@directions)
  end

  subject { @reverse.optimize }

  describe 'with a reverse operation' do
    before do
      @limit = @order.limit(2)
      @other = @limit.reverse

      @reverse = Relation::Operation::Reverse.new(@other)
    end

    it 'should cancel out the operations and return the contained operation' do
      should equal(@limit)
    end

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'with a reverse operation when optimized' do
    before do
      @limit      = @order.limit(2)
      @other      = @limit.reverse
      @projection = @other.project(@other.header)

      @reverse = Relation::Operation::Reverse.new(@projection)
    end

    it 'should cancel out the operations and return the contained operation' do
      should equal(@limit)
    end

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'with an order operation' do
    before do
      @reverse = Relation::Operation::Reverse.new(@order)
    end

    it { should eql(@relation.order(@reverse.directions)) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'with an order operation when optimized' do
    before do
      @projection = @order.project(@order.header)

      @reverse = Relation::Operation::Reverse.new(@projection)
    end

    it { should eql(@relation.order(@reverse.directions)) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'with an optimizable operation' do
    before do
      @limit      = @order.limit(2)
      @projection = @limit.project(@limit.header)

      @reverse = Relation::Operation::Reverse.new(@projection)
    end

    it { should eql(@order.limit(2).reverse) }

    it 'should return an equivalent relation to the unoptimized operation' do
      should == @reverse
    end
  end
end
