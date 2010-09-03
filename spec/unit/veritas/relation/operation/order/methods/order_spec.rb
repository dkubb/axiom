require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Methods#order' do
  subject { relation.order(*args, &block) }

  let(:args)     { []                                                   }
  let(:block)    { nil                                                  }
  let(:relation) { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }

  context 'with no arguments' do
    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == relation.header }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == relation.to_a.sort_by { |tuple| tuple[:id] }
    end
  end

  context 'with direction arguments' do
    let(:directions) { [ relation[:id].desc ] }
    let(:args)       { [ directions ]         }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == directions }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == relation.to_a.sort_by { |tuple| tuple[:id] }.reverse
    end
  end

  context 'with a block' do
    let(:block) { lambda { |relation| [ relation[:id].desc ] } }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == block.call(relation) }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == relation.to_a.sort_by { |tuple| tuple[:id] }.reverse
    end
  end
end
