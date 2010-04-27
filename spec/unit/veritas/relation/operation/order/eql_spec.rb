require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#eql?' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])
    @directions = [ @relation[:id] ]

    @order = @relation.order(@directions)
  end

  subject { @order.eql?(@other) }

  describe 'with the same order' do
    before do
      @other = @order
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@order)
    end
  end

  describe 'with an equivalent order' do
    before do
      @other = @order.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@order)
    end
  end

  describe 'with a different order' do
    before do
      @other = @order.order([ @relation[:id].desc ])
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@order)
    end
  end

  describe 'with an equivalent order of a different class' do
    before do
      klass = Class.new(Relation::Operation::Order)

      @other = klass.new(@order, @directions)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@order)
    end
  end

end
