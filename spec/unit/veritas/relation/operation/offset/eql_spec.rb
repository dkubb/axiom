require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Offset#eql?' do
  before do
    @relation   = Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ])
    @directions = [ @relation[:id] ]
    @order      = Relation::Operation::Order.new(@relation, @directions)

    @offset = @order.offset(1)
  end

  subject { @offset.eql?(@other) }

  describe 'with the same offset' do
    before do
      @other = @offset
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@offset)
    end
  end

  describe 'with an equivalent offset' do
    before do
      @other = @offset.dup
    end

    it { should be_true }

    it 'is symmetric' do
      should == @other.eql?(@offset)
    end
  end

  describe 'with a different offset' do
    before do
      @other = @offset.offset(0)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@offset)
    end
  end

  describe 'with an equivalent offset of a different class' do
    before do
      klass = Class.new(Relation::Operation::Offset)

      @other = klass.new(@offset, 1)
    end

    it { should be_false }

    it 'is symmetric' do
      should == @other.eql?(@offset)
    end
  end

end
