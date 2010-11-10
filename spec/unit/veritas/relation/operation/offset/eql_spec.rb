require 'spec_helper'

describe 'Veritas::Relation::Operation::Offset#eql?' do
  subject { offset.eql?(other) }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:offset)     { order.drop(1)                                               }

  context 'with the same offset' do
    let(:other) { offset }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(offset)
    end
  end

  context 'with an equivalent offset' do
    let(:other) { offset.dup }

    it { should be(true) }

    it 'is symmetric' do
      should == other.eql?(offset)
    end
  end

  context 'with a different offset' do
    let(:other) { offset.drop(0) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(offset)
    end
  end

  context 'with an equivalent offset of a different class' do
    let(:other) { Class.new(Relation::Operation::Offset).new(offset, 1) }

    it { should be(false) }

    it 'is symmetric' do
      should == other.eql?(offset)
    end
  end

end
