require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Limit#eql?' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:limit)      { order.limit(1)                                              }

  subject { limit.eql?(other) }

  describe 'with the same limit' do
    let(:other) { limit }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(limit)
    end
  end

  describe 'with an equivalent limit' do
    let(:other) { limit.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(limit)
    end
  end

  describe 'with a different limit' do
    let(:other) { order.limit(2) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(limit)
    end
  end

  describe 'with an equivalent limit of a different class' do
    let(:other) { Class.new(Relation::Operation::Limit).new(order, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(limit)
    end
  end
end
