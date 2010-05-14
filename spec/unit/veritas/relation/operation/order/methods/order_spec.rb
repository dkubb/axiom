require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Methods#order' do
  subject { relation.order(*args, &block) }

  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with direction arguments' do
    let(:directions) { [ relation[:id].asc ] }
    let(:args)       { [ directions ]        }
    let(:block)      { nil                   }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == directions }

    it 'behaves the same as Array#sort_by' do
      should == relation.to_a.sort_by { |tuple| tuple[:id] }
    end
  end

  context 'with a block' do
    let(:args)  { []                                          }
    let(:block) { lambda { |relation| [ relation[:id].asc ] } }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == block.call(relation) }

    it 'behaves the same as Array#sort_by' do
      should == relation.to_a.sort_by { |tuple| tuple[:id] }
    end
  end
end
