require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#optimize' do
  subject { order.optimize }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }

  context 'containing a relation' do
    let(:order) { relation.order(directions) }

    it { should equal(order) }
  end

  context 'containing an optimizable relation' do
    let(:projection) { relation.project(relation.header) }
    let(:order)      { projection.order(directions)      }

    it { should eql(relation.order(directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == order
    end
  end

  context 'containing an order operation' do
    let(:original) { relation.order { |r| [ r[:id].desc ] } }
    let(:order)    { original.order(directions)             }

    it { should eql(relation.order(directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == order
    end
  end

  context 'containing a reverse operation' do
    let(:original) { relation.order { |r| [ r[:id] ] }  }
    let(:order)    { original.reverse.order(directions) }

    it { should eql(relation.order(directions)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == order
    end
  end

  context 'containing a limit(1) operation' do
    let(:original) { relation.order { |r| [ r[:id] ] }   }
    let(:order)    { original.limit(1).order(directions) }

    it { should eql(original.limit(1)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == order
    end
  end
end
