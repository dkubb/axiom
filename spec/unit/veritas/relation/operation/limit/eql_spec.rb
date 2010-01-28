require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#eql?' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @limit = @order.limit(1)
  end

  subject { @limit.eql?(@other) }

  describe 'with the same limit' do
    before do
      @other = @limit
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@limit)
    end
  end

  describe 'with an equivalent limit' do
    before do
      @other = @limit.dup
    end

    it { should be_true }

    it 'should be symmetric' do
      should == @other.eql?(@limit)
    end
  end

  describe 'with a different limit' do
    before do
      @other = @order.limit(2)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@limit)
    end
  end

  describe 'with an equivalent limit of a different class' do
    before do
      klass = Class.new(Relation::Operation::Limit)

      @other = klass.new(@order, 1)
    end

    it { should be_false }

    it 'should be symmetric' do
      should == @other.eql?(@limit)
    end
  end
end
