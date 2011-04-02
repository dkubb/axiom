require 'spec_helper'

describe Relation::Operation::Order::Methods, '#order' do
  let(:klass)  { Relation                                               }
  let(:object) { klass.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }

  context 'with no arguments' do
    subject { object.order }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == object.header }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == object.to_a.sort_by { |tuple| tuple[:id] }
    end
  end

  context 'with direction arguments' do
    subject { object.order(directions) }

    let(:directions) { [ object[:id].desc ] }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == directions }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == object.to_a.sort_by { |tuple| tuple[:id] }.reverse
    end
  end

  context 'with a block' do
    subject { object.order(&block) }

    let(:block) { lambda { |relation| [ relation[:id].desc ] } }

    it { should be_kind_of(Relation::Operation::Order) }

    its(:directions) { should == block.call(object) }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should == object.to_a.sort_by { |tuple| tuple[:id] }.reverse
    end
  end
end
