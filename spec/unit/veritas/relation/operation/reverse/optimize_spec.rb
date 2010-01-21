require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Reverse#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = Relation::Operation::Order::DirectionSet.new([ @relation[:id] ])
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @reverse = Relation::Operation::Reverse.new(@order)
  end

  subject { @reverse.optimize }

  describe 'with a reverse operation' do
    before do
      @reverse = Relation::Operation::Reverse.new(@reverse)
    end

    it { should equal(@order) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'with a reverse operation when optimized' do
    before do
      @projection = Algebra::Projection.new(@reverse, @reverse.header)

      @reverse = Relation::Operation::Reverse.new(@projection)
    end

    it { should equal(@order) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @reverse
    end
  end

  describe 'without a reverse operation' do
    it { should equal(@reverse) }
  end
end
