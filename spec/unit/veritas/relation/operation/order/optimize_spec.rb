require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
  end

  subject { @order.optimize }

  describe 'containing a relation' do
    before do
      @order = @relation.order(@directions)
    end

    it { should equal(@order) }
  end

  describe 'containing an optimizable relation' do
    before do
      @projection = @relation.project(@relation.header)

      @order = @projection.order(@directions)
    end

    it { should eql(@relation.order(@directions)) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @order
    end
  end

  describe 'containing an order operation' do
    before do
      @original = @relation.order { |r| [ r[:id].desc ] }

      @order = @original.order(@directions)
    end

    it { should eql(@relation.order(@directions)) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @order
    end
  end

  describe 'containing a reverse operation' do
    before do
      @original = @relation.order { |r| [ r[:id] ] }

      @order = @original.reverse.order(@directions)
    end

    it { should eql(@relation.order(@directions)) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @order
    end
  end
end
