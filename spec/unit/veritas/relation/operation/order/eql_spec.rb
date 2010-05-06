require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Operation::Order#eql?' do
  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:directions) { [ relation[:id] ]                                    }
  let(:order)      { relation.order(directions)                           }

  subject { order.eql?(other) }

  describe 'with the same order' do
    let(:other) { order }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(order)
    end
  end

  describe 'with an equivalent order' do
    let(:other) { order.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(order)
    end
  end

  describe 'with a different order' do
    let(:other) { order.order([ relation[:id].desc ]) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(order)
    end
  end

  describe 'with an equivalent order of a different class' do
    let(:other) { Class.new(Relation::Operation::Order).new(order, directions) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(order)
    end
  end

end
