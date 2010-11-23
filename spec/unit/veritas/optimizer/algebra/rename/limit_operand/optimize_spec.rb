require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Rename::LimitOperand#optimize' do
  subject { object.optimize }

  let(:klass)    { Optimizer::Algebra::Rename::LimitOperand    }
  let(:header)   { Relation::Header.new([ [ :id, Integer ] ])  }
  let(:base)     { Relation.new(header, [ [ 1 ] ].each)        }
  let(:relation) { base.order.take(2).rename(:id => :other_id) }
  let(:object)   { klass.new(relation)                         }

  before do
    object.operation.should be_kind_of(Algebra::Rename)
    object.operand.should be_kind_of(Relation::Operation::Limit)
  end

  it { should be_kind_of(Relation::Operation::Limit) }

  its(:operand) { should eql(base.rename(:id => :other_id).order) }

  its(:limit) { should == 2 }
end
