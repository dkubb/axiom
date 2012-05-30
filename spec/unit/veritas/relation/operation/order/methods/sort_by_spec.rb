# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Order::Methods, '#sort_by' do
  let(:described_class) { Relation                                                         }
  let(:object)          { described_class.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ].each) }

  context 'with no block' do
    subject { object.sort_by }

    specify { expect { subject }.to raise_error(LocalJumpError) }
  end

  context 'with a block' do
    subject { object.sort_by(&block) }

    let(:block) { lambda { |relation| [ relation[:id].desc ] } }

    it { should be_instance_of(Relation::Operation::Order) }

    its(:directions) { should == block.call(object) }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should eql(object.to_a.sort_by { |tuple| tuple[:id] }.reverse)
    end
  end

  context 'with directions' do
    subject { object.sort_by(directions) }

    let(:directions) { Relation::Operation::Order::DirectionSet.coerce(object.header) }

    it { should be_instance_of(Relation::Operation::Order) }

    its(:directions) { should equal(directions) }

    it 'behaves the same as Array#sort_by' do
      subject.to_a.should eql(object.to_a.sort_by { |tuple| tuple[:id] })
    end
  end
end
