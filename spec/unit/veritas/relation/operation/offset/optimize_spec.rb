require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#optimize' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)
  end

  subject { @offset.optimize }

  describe 'with an offset of 0' do
    before do
      @offset = @order.offset(0)
    end

    it { should equal(@order) }

    it 'should return the same tuples as the unoptimized operation' do
      should == @offset
    end
  end

  describe 'containing an order operation' do
    before do
      @offset = Relation::Operation::Offset.new(@order, 1)
    end

    it { should equal(@offset) }
  end

  describe 'containing an optimizable order operation' do
    before do
      @projection = @order.project(@order.header)

      @offset = Relation::Operation::Offset.new(@projection, 1)
    end

    it { should be_instance_of(Relation::Operation::Offset) }

    it { subject.relation.should equal(@order) }

    it { subject.to_i.should == 1 }

    it 'should return the same tuples as the unoptimized operation' do
      should == @offset
    end
  end

  describe 'containing an offset operation' do
    before do
      @original = Relation::Operation::Offset.new(@order, 5)

      @offset = Relation::Operation::Offset.new(@original, 10)
    end

    it { should be_instance_of(Relation::Operation::Offset) }

    it { subject.relation.should equal(@order) }

    it 'should add the offset of the operations' do
      subject.to_i.should == 15
    end

    it 'should return the same tuples as the unoptimized operation' do
      should == @offset
    end
  end
end
