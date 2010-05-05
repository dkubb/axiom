require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)
  end

  subject { @limit.optimize }

  describe 'when the limit is 0' do
    before do
      @limit = @order.limit(0)
    end

    it { should be_kind_of(Relation::Empty) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing an order operation' do
    before do
      @limit = Relation::Operation::Limit.new(@order, 1)
    end

    it { should equal(@limit) }
  end

  describe 'containing an optimizable order operation' do
    before do
      @projection = @order.project(@order.header)

      @limit = Relation::Operation::Limit.new(@projection, 1)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(@order) }

    its(:to_i) { should == 1 }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a more restrictive limit operation' do
    before do
      @limit = Relation::Operation::Limit.new(@order, 5)

      @limit = Relation::Operation::Limit.new(@limit, 10)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(@order) }

    it 'uses the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a less restrictive limit operation' do
    before do
      @original = Relation::Operation::Limit.new(@order, 10)

      @limit = Relation::Operation::Limit.new(@original, 5)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    its(:relation) { should equal(@order) }

    it 'uses the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a similar limit operation' do
    before do
      @original = Relation::Operation::Limit.new(@order, 10)

      @limit = Relation::Operation::Limit.new(@original, 10)
    end

    it { should equal(@original) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == @limit
    end
  end
end
