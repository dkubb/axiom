require 'spec_helper'

describe 'Veritas::Relation::Operation::Order#wrap' do
  subject { order.wrap(*args) { |relation| relation } }

  let(:relation)   { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ], [ 3 ] ]) }
  let(:directions) { [ relation[:id] ]                                           }
  let(:order)      { Relation::Operation::Order.new(relation, directions)        }
  let(:yields)     { []                                                          }

  context 'without directions' do
    let(:args) { [] }

    it { should_not be_equal(order) }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'yields the relations' do
      expect {
        order.wrap { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ relation ])
    end

    it 'sets the relation with the block return values' do
      operation = order.wrap { relation }
      operation.operand.should equal(relation)
    end

    its(:directions) { should == directions }
  end

  context 'with directions' do
    let(:args) { [ directions ] }

    it { should_not be_equal(order) }

    it { should be_kind_of(Relation::Operation::Order) }

    it 'yields the relations' do
      expect {
        order.wrap(directions) { |relation| yields << relation; relation }
      }.to change { yields.dup }.from([]).to([ relation ])
    end

    it 'sets the relation with the block return values' do
      operation = order.wrap(directions) { relation }
      operation.operand.should equal(relation)
    end

    its(:directions) { should == directions }
  end
end
