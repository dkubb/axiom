require 'spec_helper'

describe Optimizer::Algebra::Rename::LimitOperand, '#optimize' do
  subject { object.optimize }

  let(:header)   { Relation::Header.new([ [ :id, Integer ] ]) }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)       }
  let(:order)    { base.order                                 }
  let(:relation) { order.take(2).rename(:id => :other_id)     }
  let(:object)   { described_class.new(relation)              }

  before do
    object.should be_optimizable
  end

  it { should be_kind_of(Relation::Operation::Limit) }

  its(:operand) { should eql(order.rename(:id => :other_id)) }

  its(:limit) { should == 2 }
end
