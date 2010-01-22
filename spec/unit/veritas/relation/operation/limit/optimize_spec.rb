require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)
  end

  subject { @limit.optimize }

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

    it { subject.relation.should equal(@order) }

    it { subject.to_i.should == 1 }

    it 'should return the same tuples as the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a more restrictive limit operation' do
    before do
      @limit = Relation::Operation::Limit.new(@order, 5)

      @limit = Relation::Operation::Limit.new(@limit, 10)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    it { subject.relation.should equal(@order) }

    it 'should use the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'should return the same tuples as the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a less restrictive limit operation' do
    before do
      @original = Relation::Operation::Limit.new(@order, 10)

      @limit = Relation::Operation::Limit.new(@original, 5)
    end

    it { should be_instance_of(Relation::Operation::Limit) }

    it { subject.relation.should equal(@order) }

    it 'should use the more restrictive limit' do
      subject.to_i.should == 5
    end

    it 'should return the same tuples as the unoptimized operation' do
      should == @limit
    end
  end

  describe 'containing a similar limit operation' do
    before do
      @original = Relation::Operation::Limit.new(@order, 10)

      @limit = Relation::Operation::Limit.new(@original, 10)
    end

    it { should equal(@original) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @limit
    end
  end
end
